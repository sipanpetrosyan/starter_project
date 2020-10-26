import 'package:flutter/material.dart';
import 'package:igroove_ui/base/app_keys.dart';
import 'package:igroove_ui/models/user.dart';
import 'package:igroove_ui/ui/pages/change_email.dart';
import 'package:igroove_ui/ui/pages/change_password.dart';
import 'package:igroove_ui/ui/pages/forgot_pass.dart';
import 'package:igroove_ui/ui/pages/home.dart';
import 'package:igroove_ui/ui/pages/login.dart';
import 'package:igroove_ui/ui/pages/register.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = UserModel();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppKeys.navigatorKey,
      home: LoginPage(),
      routes: {
        'forgotPass': (context) => ForgotPassPage(),
        'register': (context) => RegisterPage(),
        'homePage': (context) => HomePage(),
        'changeEmail': (context) => ChangeEmailPage(),
        'changePassword': (context) => ChangePasswordPage()
      },
    );
  }
}
