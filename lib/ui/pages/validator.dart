import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static final nameValidator =
      RequiredValidator(errorText: 'First name can not be empty');
  static final lastNameValidator =
      RequiredValidator(errorText: 'Last name can not be empty');

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email can not be empty'),
    EmailValidator(errorText: 'Enter valid email address')
  ]);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password can not be empty'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  ]);
}
