init: docker-down-clear \
			api-clear frontend-clear \
			docker-pull docker-build up \
			api-init frontend-init
up: docker-up
down: docker-down
restart: down up
check: lint analyze test
lint: api-lint
analyze: api-analyze
test: api-test
test-coverage: api-test-coverage
test-functional: api-test-functional
test-functional-coverage: api-test-functional-coverage
test-unit: api-test-unit
test-unit-coverage: api-test-unit-coverage

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build --pull

api-init: api-composer-install api-permission api-migrate-clear

api-clear:
	docker run --rm -v ${PWD}/backend:/app -w /app alpine sh -c 'rm -rf var/*'

api-permission:
	docker run --rm -v ${PWD}/backend:/app -w /app alpine chmod -R 777 storage bootstrap/cache

api-composer-install:
	docker-compose run --rm api-php-cli composer install

api-lint-fix:
	docker-compose run --rm api-php-cli composer cs-fix

api-lint:
	docker-compose run --rm api-php-cli composer lint
	docker-compose run --rm api-php-cli composer cs-check

api-analyze:
	docker-compose run --rm api-php-cli composer psalm

api-test:
	docker-compose run --rm api-php-cli composer test

api-test-coverage:
	docker-compose run --rm api-php-cli composer test-coverage

api-test-functional:
	docker-compose run --rm api-php-cli composer test -- --testsuit=functional

api-test-functional-coverage:
	docker-compose run --rm api-php-cli composer test-coverage -- --testsuit=functional

api-test-unit:
	docker-compose run --rm api-php-cli composer test -- --testsuit=unit

api-test-unit-coverage:
	docker-compose run --rm api-php-cli composer test-coverage -- --testsuit=unit

api-route-list:
	docker-compose run --rm api-php-cli php artisan route:list

api-migrate:
	docker-compose run --rm api-php-cli php artisan migrate

api-migrate-clear:
	docker-compose run --rm api-php-cli php artisan migrate:fresh
	docker-compose run --rm api-php-cli php artisan orchid:admin admin admin@mail.com secret

clear-logs:
		docker run --rm -v ${PWD}/frontend:/app -w /app alpine sh -c 'rm -rf docker/development/nginx/logs/*.log'
		docker run --rm -v ${PWD}/gateway:/app -w /app alpine sh -c 'rm -rf docker/development/nginx/logs/*.log'
		docker run --rm -v ${PWD}/backend:/app -w /app alpine sh -c 'rm -rf storage/logs/*.log'

frontend-clear:
	docker run --rm -v ${PWD}/frontend:/app -w /app alpine sh -c 'rm -rf .nuxt'

frontend-init: frontend-npm-install

frontend-npm-install:
	docker-compose run --rm frontend-node-cli npm install

build: build-gateway build-frontend build-api

build-gateway:
	docker --log-level=debug build --pull --file=gateway/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-gateway:${IMAGE_TAG} gateway/docker
build-frontend:
	docker --log-level=debug build --pull --file=frontend/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-frontend:${IMAGE_TAG} frontend

build-api:
	docker --log-level=debug build --pull --file=backend/docker/production/php-fpm/Dockerfile --tag=${REGISTRY}/auction-api-php-fpm:${IMAGE_TAG} backend
	docker --log-level=debug build --pull --file=backend/docker/production/php-cli/Dockerfile --tag=${REGISTRY}/auction-api-php-cli:${IMAGE_TAG} backend
	docker --log-level=debug build --pull --file=backend/docker/production/nginx/Dockerfile --tag=${REGISTRY}/auction-api:${IMAGE_TAG} backend

try-build:
	REGISTRY=localhost IMAGE_TAG=0 make build

push: push-gateway push-frontend push-api

full-deploy: build push deploy

push-gateway:
	docker push ${REGISTRY}/auction-gateway:${IMAGE_TAG}

push-frontend:
	docker push ${REGISTRY}/auction-frontend:${IMAGE_TAG}

push-api:
	docker push ${REGISTRY}/auction-api:${IMAGE_TAG}
	docker push ${REGISTRY}/auction-api-php-fpm:${IMAGE_TAG}
	docker push ${REGISTRY}/auction-api-php-cli:${IMAGE_TAG}

deploy:
	ssh ${HOST} -p ${PORT} 'rm -rf site_${BUILD_NUMBER}'
	ssh ${HOST} -p ${PORT} 'mkdir site_${BUILD_NUMBER}'
	scp -P ${PORT} docker-compose-production.yml ${HOST}:site_${BUILD_NUMBER}/docker-compose.yml
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && echo "COMPOSE_PROJECT_NAME=auction" >> .env'
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && echo "REGISTRY=${REGISTRY}" >> .env'
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && echo "IMAGE_TAG=${IMAGE_TAG}" >> .env'
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && docker-compose pull'
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && docker-compose up --build --remove-orphans -d'
	ssh ${HOST} -p ${PORT} 'rm -f site'
	ssh ${HOST} -p ${PORT} 'ln -sr site_${BUILD_NUMBER} site'

rollback:
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && docker-compose pull'
	ssh ${HOST} -p ${PORT} 'cd site_${BUILD_NUMBER} && docker-compose up --build --remove-orphans -d'
	ssh ${HOST} -p ${PORT} 'rm -f site'
	ssh ${HOST} -p ${PORT} 'ln -sr site_${BUILD_NUMBER} site'
