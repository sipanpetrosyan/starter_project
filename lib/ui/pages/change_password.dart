import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/validator.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ConstVariables constVariables = ConstVariables();
  final TextEditingController passController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool isPassValid = true;
  bool isWrongPass = true;
  bool isConfirmPass = true;
  String errorPassMesage;
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
                  'Change password',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontSize: constVariables.screenWidth > 320 ? 20 : 16),
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
                        controller: passController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText:
                              isWrongPass ? 'Password' : 'Wrong password',
                          labelStyle: TextStyle(
                              color: isWrongPass
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
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(255, 244, 129, 79),
                    ),
                    child: TextFormField(
                      controller: newPassController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                      ),
                      decoration: InputDecoration(
                        labelText:
                            isPassValid ? 'New password' : errorPassMesage,
                        labelStyle: TextStyle(
                            color: isPassValid
                                ? Color.fromARGB(255, 244, 129, 79)
                                : Colors.red),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 200, 200, 200)),
                        ),
                      ),
                      onChanged: (input) {},
                      obscureText: true,
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(255, 244, 129, 79),
                    ),
                    child: TextFormField(
                      controller: confirmPassController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                      ),
                      decoration: InputDecoration(
                        labelText: isConfirmPass
                            ? 'Confirm Password'
                            : 'Wrong confirm password',
                        labelStyle: TextStyle(
                            color: isConfirmPass
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
                onTap: () async {
                  errorPassMesage =
                      Validator.passwordValidator.call(newPassController.text);
                  isPassValid = errorPassMesage == null;
                  setState(() {});
                  if (isPassValid &&
                      (newPassController.text == confirmPassController.text)) {
                    String error = await AppManager()
                        .userMeneger
                        .changeDbUserPassword(
                            newPassword: newPassController.text,
                            password: passController.text);

                    if (error != null) {
                      print(error);
                      passController.text = "";
                      newPassController.text = "";
                      confirmPassController.text = "";
                      isWrongPass = false;
                      setState(() {});
                    } else {
                      setState(() {});
                      Navigator.pop(context);
                    }

                    print('Save');
                    // Navigator.pop(context);
                  }
                  if (newPassController.text != confirmPassController.text) {
                    setState(() {
                      newPassController.text = "";
                      confirmPassController.text = "";
                      isConfirmPass = false;
                    });
                  }
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
                  )),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
