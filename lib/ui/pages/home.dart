import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _email, _password;

  ConstVariables constVariables;
  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables(context: context);

    return Scaffold(
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          height: constVariables.screenHeight,
          width: constVariables.screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Login – 1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: constVariables.screenWidth * 0.1,
                right: constVariables.screenWidth * 0.1,
                top: constVariables.screenWidth * 0.3),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/newwave-logo-icon.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 35),
                      child: Text(
                        'Welcome to \nNew Wave.',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        onChanged: (input) => _email = input,
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        onChanged: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: constVariables.screenWidth * 0.8,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 7),
                  child: GestureDetector(
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 188, 166, 188),
                          fontFamily: "Montserrat",
                          fontSize: 13),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('forgotPass');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ButtonTheme(
                    minWidth: constVariables.screenWidth,
                    height: 50,
                    child: RaisedButton(
                      color: Color.fromARGB(255, 232, 107, 44),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamed('trends');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
