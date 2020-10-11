import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter valid email'),
    EmailValidator(errorText: 'Enter valid email address')
  ]);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password can not be empty'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);
}
