import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/validator.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  ConstVariables constVariables = ConstVariables();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isEmailValid = true;
  bool isPassValid = true;
  String errorEmailMesage;
  String errorPassMesage;
  bool textFiledFocus;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 64,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Color.fromARGB(255, 244, 129, 79),
                          size: 25,
                        ),
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                            color: Color.fromARGB(255, 244, 129, 79),
                            fontFamily: "Montserrat",
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Change email',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              SizedBox(
                width: 64,
              )
            ],
          ),
        ),
        body: bodyContent(),
      ),
    );
  }

  Widget bodyContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Color.fromARGB(255, 244, 129, 79),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText:
                              isEmailValid ? 'New email' : errorEmailMesage,
                          labelStyle: TextStyle(
                              color: isEmailValid
                                  ? Color.fromARGB(255, 244, 129, 79)
                                  : Colors.red),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 200, 200, 200)),
                          ),
                        ),
                        onChanged: (input) {},
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(255, 244, 129, 79),
                    ),
                    child: TextFormField(
                      autofocus: textFiledFocus ?? false,
                      controller: passController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                      ),
                      decoration: InputDecoration(
                        labelText: isPassValid ? 'Password' : errorPassMesage,
                        labelStyle: TextStyle(
                            color: isPassValid
                                ? Color.fromARGB(255, 244, 129, 79)
                                : Colors.red),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 200, 200, 200)),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              width: constVariables.screenWidth,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 4.0,
                      offset: Offset(0.0, 0.75))
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: constVariables.screenWidth * 0.14,
              right: constVariables.screenWidth * 0.14,
              bottom: 12,
              child: GestureDetector(
                onTap: () {
                  saveChangeEmail();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 129, 79),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  saveChangeEmail() async {
    errorEmailMesage = Validator.emailValidator.call(emailController.text);
    isEmailValid = errorEmailMesage == null;
    errorPassMesage = Validator.passwordValidator.call(passController.text);
    isPassValid = errorPassMesage == null;
    setState(() {});
    if (isEmailValid && isPassValid) {
      //check email already exists
      bool checkResult = await AppManager()
          .userMeneger
          .checkDbUserExistingByEmail(emailController.text);

      if (!checkResult) {
        //change email user db
        String error = await AppManager().userMeneger.changeDbUserEmail(
            newEmail: emailController.text, password: passController.text);

        if (error != null) {
          print(error);
          passController.text = '';
          isPassValid = false;
          textFiledFocus = false;
          errorPassMesage = error;
          setState(() {});
        } else {
          setState(() {});
          Navigator.pop(context);
        }
      } else {
        emailController.text = '';
        passController.text = '';
        isEmailValid = false;
        errorEmailMesage = 'Email already exists';
      }
    }
  }
}
