import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  ConstVariables constVariables = ConstVariables();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // color: Colors.blue,
                width: 54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Color.fromARGB(255, 244, 129, 79),
                        size: 15,
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
              width: 54,
            )
            // siz
          ],
        ),
      ),
      body: bodyContent(),
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                        decoration: InputDecoration(
                          labelText: 'New email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 200, 200, 200)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                      primaryColor: Color.fromARGB(255, 244, 129, 79),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 200, 200, 200)),
                        ),
                      ),
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
                  ),
                )),
              ),
            )
          ],
        )
      ],
    );
  }
}
