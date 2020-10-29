import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/validator.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = true;
  String errorEmailMesage;
  ConstVariables constVariables;

  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables();
    return Scaffold(
      body: forgotContent(),
    );
  }

  Widget forgotContent() {
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
                      padding: const EdgeInsets.only(top: 65, bottom: 10),
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        'Please enter your email address and we will send you a new password.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
                        onChanged: (input){},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: constVariables.screenWidth * 0.3),
                  child: ButtonTheme(
                    minWidth: constVariables.screenWidth,
                    height: 50,
                    child: RaisedButton(
                      color: Color.fromARGB(255, 232, 107, 44),
                      textColor: Colors.white,
                      onPressed: () {
                        errorEmailMesage =
                            Validator.emailValidator.call(emailController.text);
                        isEmailValid = errorEmailMesage == null;
                        setState(() {});
                        if (isEmailValid) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Request new password",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
