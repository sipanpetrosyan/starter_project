import 'package:flutter/material.dart';
import 'package:igroove_ui/ui/pages/forgot_pass.dart';
import 'package:igroove_ui/ui/pages/home.dart';
import 'package:igroove_ui/ui/pages/my_trends.dart';
import 'package:load/load.dart';

void main() {
  runApp(
    LoadingProvider(
      themeData: LoadingThemeData(),
      loadingWidgetBuilder: (ctx, data) {
        return Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor:
                    AlwaysStoppedAnimation(Color.fromARGB(255, 244, 129, 79)),
              ),
              color: Color.fromRGBO(104, 104, 104, 0),
            ),
          ),
        );
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        'forgotPass': (context) => ForgotPassPage(),
        'trends': (context) => MyTrends(),
      },
    );
  }
}
