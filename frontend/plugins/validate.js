import {required, email, min} from 'vee-validate/dist/rules'
import {extend, setInteractionMode} from 'vee-validate';
// import Vue from 'vue';

setInteractionMode('eager');

extend(
  'required', {
    ...required,
    'message': 'Поле не может быть пустым'
  }
);

extend(
  'email', {
    ...email,
    'message': 'Email должен быть валидным'
  }
);

extend(
  'min', {
    ...min,
    'message': 'Поле должно иметь минимум {length} знаков'
  }
);
