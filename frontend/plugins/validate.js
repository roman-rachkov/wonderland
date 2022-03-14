import * as rules from 'vee-validate/dist/rules'
import {extend, setInteractionMode, localize} from 'vee-validate';
import ru from 'vee-validate/dist/locale/ru.json';

setInteractionMode('eager');

localize('ru', ru)

Object.keys(rules).forEach(rule => {
  extend(rule, rules[rule]);
});
