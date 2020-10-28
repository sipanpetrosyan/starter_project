import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:igroove_ui/db/database.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/models/user_db.dart';
import 'package:igroove_ui/ui/pages/validator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _firstName, _lastName, _email, _password;
  final TextEditingController firstNameController =
      TextEditingController(text: "DSf");
  final TextEditingController lastNameController =
      TextEditingController(text: "sdf");
  final TextEditingController emailController =
      TextEditingController(text: "dfsdfsd@df.df");
  final TextEditingController passController =
      TextEditingController(text: "dsfsdfsdfsdfsdf");
  bool isNameValid = true;
  bool isLastNameValid = true;
  bool isEmailValid = true;
  bool isPassValid = true;
  String errorNameMesage;
  String errorLastNameMesage;
  String errorEmailMesage;
  String errorPassMesage;

  ConstVariables constVariables;

  @override
  void initState() {
    super.initState();
  }

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
                        'Registration',
                        style: TextStyle(
                          fontSize: 21,
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
                              color: isNameValid ? Colors.white : Colors.red),
                        ),
                      ),
                      child: TextFormField(
                        controller: firstNameController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText:
                              isNameValid ? 'First name' : errorNameMesage,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        onChanged: (input) => _firstName = input,
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color:
                                  isLastNameValid ? Colors.white : Colors.red),
                        ),
                      ),
                      child: TextFormField(
                        controller: lastNameController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: isLastNameValid
                              ? 'Last name'
                              : errorLastNameMesage,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 130, 130, 130)),
                          ),
                        ),
                        onChanged: (input) => _lastName = input,
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
                        onChanged: (input) => _email = input,
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
                        // validator: (val) =>
                        //     MatchValidator(errorText: 'passwords do not match')
                        //         .validateMatch(val, _password),
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
                Padding(
                  padding:
                      EdgeInsets.only(top: constVariables.screenWidth * 0.15),
                  child: ButtonTheme(
                    minWidth: constVariables.screenWidth,
                    height: 50,
                    child: RaisedButton(
                      color: Color.fromARGB(255, 232, 107, 44),
                      textColor: Colors.white,
                      onPressed: () {
                        errorNameMesage = Validator.nameValidator
                            .call(firstNameController.text);
                        errorLastNameMesage = Validator.lastNameValidator
                            .call(lastNameController.text);
                        errorEmailMesage =
                            Validator.emailValidator.call(emailController.text);
                        errorPassMesage = Validator.passwordValidator
                            .call(passController.text);
                        isNameValid = errorNameMesage == null;
                        isLastNameValid = errorLastNameMesage == null;
                        isEmailValid = errorEmailMesage == null;
                        isPassValid = errorPassMesage == null;
                        setState(() {});
                        if (isNameValid &&
                            isLastNameValid &&
                            isEmailValid &&
                            isPassValid) {
                          // DatabaseProvider.db.getUsers();

                          String id = Uuid().v4();

                          DatabaseProvider.db.insert({
                            DatabaseProvider.FIRST_NAME:
                                firstNameController.text,
                            DatabaseProvider.COLUMN_ID: id,
                            DatabaseProvider.LAST_NAME: lastNameController.text,
                            DatabaseProvider.EMAIL: emailController.text,
                            DatabaseProvider.PASSWORD: passController.text,
                          }).then((value) {
                            // DatabaseProvider.db.getUser(id).then((user) {
                            //   print(user.firstName);
                            // });
                          });

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
