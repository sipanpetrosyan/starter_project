import 'package:flutter/material.dart';
import 'package:igroove_ui/base/app_keys.dart';
import 'package:igroove_ui/ui/pages/change_email.dart';
import 'package:igroove_ui/ui/pages/change_password.dart';
import 'package:igroove_ui/ui/pages/forgot_pass.dart';
import 'package:igroove_ui/ui/pages/home.dart';
import 'package:igroove_ui/ui/pages/my_trends.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      home: LoginPage(),
      routes: {
        'forgotPass': (context) => ForgotPassPage(),
        'trends': (context) => MyTrends(),
        'changeEmail': (context) => ChangeEmailPage(),
        'changePassword': (context) => ChangePasswordPage()
      },
    );
  }
}
