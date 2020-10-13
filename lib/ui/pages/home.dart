import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isEmailValid = true;
  bool isPassValid = true;
  String errorEmailMesage;
  String errorPassMesage;
  String errorEmail;
  ConstVariables constVariables;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyContent(context),
    );
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    constVariables = ConstVariables();
  }

  Widget bodyContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
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
                          labelStyle: TextStyle(
                              color: isEmailValid ? Colors.white : Colors.red),
                        ),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: isEmailValid ? 'Email' : errorEmailMesage,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        onChanged: (input) {
                          _email = input;
                        },
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color: isPassValid ? Colors.white : Colors.red),
                        ),
                      ),
                      child: TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.text,
                        validator: (val) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(val, _password),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: isPassValid ? 'Password' : errorPassMesage,
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
                        errorEmailMesage =
                            Validator.emailValidator.call(emailController.text);
                        errorPassMesage = Validator.passwordValidator
                            .call(passController.text);
                        isEmailValid = errorEmailMesage == null;
                        isPassValid = errorPassMesage == null;

                        setState(() {});
                        print(emailController.text);
                        if (isEmailValid && isPassValid) {
                          Navigator.of(context).pushNamed('trends');
                          emailController = TextEditingController();
                          passController = TextEditingController();
                        }
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
