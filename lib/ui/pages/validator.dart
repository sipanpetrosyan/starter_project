import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'this field is required'),
    EmailValidator(errorText: 'enter valid email')
  ]);

  // static final emailValid = EmailValidator(errorText: 'null');

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  ]);
}
