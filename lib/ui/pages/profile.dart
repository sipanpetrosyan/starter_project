import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igroove_ui/base/app_keys.dart';
import 'package:igroove_ui/db/database.dart';
import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ConstVariables constVariables = ConstVariables();
  TextEditingController firstName =
      TextEditingController(text: AppManager().userMeneger.user.firstName);
  TextEditingController lastName =
      TextEditingController(text: AppManager().userMeneger.user.lastName);
  TextEditingController email =
      TextEditingController(text: AppManager().userMeneger.user.email);
  TextEditingController password = TextEditingController(text: "password");
  FocusNode focusNode = FocusNode();
  File _image;
  int _value = 1;
  static List<String> dropdownLengList = ['English', 'Russian', 'Armenian'];
  String selectLenguage = dropdownLengList[0];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: 100,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'My profile',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    print(firstName.text);
                    AppManager().userMeneger.updateDbUser(
                        field: DatabaseProvider.FIRST_NAME,
                        newWalue: firstName.text);
                    AppManager().userMeneger.updateDbUser(
                        field: DatabaseProvider.LAST_NAME,
                        newWalue: lastName.text);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Color.fromARGB(255, 244, 129, 79),
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: constVariables.screenWidth,
                      height: 150,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 220, 220, 220),
                          Color.fromARGB(255, 200, 200, 200),
                          Colors.white,
                          Color.fromARGB(255, 180, 180, 180),
                          Colors.grey
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      child: Container(
                        color: Colors.white,
                        child: AppManager().userMeneger.user.profileImageUrl !=
                                null
                            ? ClipRRect(
                                child: Image.file(
                                  File(AppManager()
                                      .userMeneger
                                      .user
                                      .profileImageUrl),
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey[800],
                                    size: constVariables.screenWidth * 0.2,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    print('Log out');
                    AppKeys.navigatorKey.currentState.popUntil(
                      (route) {
                        return route.settings.name == "/";
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                              color: Color.fromARGB(255, 244, 129, 79),
                              fontFamily: "Montserrat",
                              fontSize: 16),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 200, 200, 200),
                  width: constVariables.screenWidth,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'Profile informations',
                      style: TextStyle(fontFamily: "Montserrat"),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'First name',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.purple[500],
                        ),
                        child: TextFormField(
                          controller: firstName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 200, 200)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Last name',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.purple[500],
                        ),
                        child: TextFormField(
                          controller: lastName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 200, 200)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Color.fromARGB(255, 200, 200, 200),
                        ),
                        child: TextFormField(
                          controller: email,
                          onTap: () {
                            print('Email');
                            setState(() {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });

                            Navigator.of(context).pushNamed('changeEmail');
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 200, 200)),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(maxHeight: 20, maxWidth: 20),
                            suffixIcon: Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          primaryColor: Color.fromARGB(255, 200, 200, 200),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          controller: password,
                          onTap: () {
                            setState(() {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                            print('password');
                            Navigator.of(context).pushNamed('changePassword');
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 200, 200, 200)),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(maxHeight: 20, maxWidth: 20),
                            suffixIcon: Icon(Icons.chevron_right),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Lenguage',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          FocusScope.of(context).requestFocus(focusNode);
                        },
                        child: PopupMenuButton<int>(
                          onSelected: (value) {
                            setState(() {
                              selectLenguage = dropdownLengList[value];
                            });
                          },
                          itemBuilder: (context) => [
                            ...List.generate(
                              dropdownLengList.length,
                              (index) => PopupMenuItem(
                                value: index,
                                child: Text(
                                  dropdownLengList[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                            ),
                          ],
                          offset: Offset(1, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              height: 50,
                              width: constVariables.screenWidth,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 2.0,
                                      color:
                                          Color.fromARGB(255, 220, 220, 220)),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectLenguage,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Color.fromARGB(255, 150, 150, 150),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _paddingPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "English",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              "Chinese",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        elevation: 4,
        padding: EdgeInsets.symmetric(horizontal: 50),
      );

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    String error = await AppManager()
        .userMeneger
        .updateDbUser(field: DatabaseProvider.IMAGE, newWalue: image.path);

    if (error != null) {
      print(error);

      ///Show error
    }

    setState(() {});
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    String error = await AppManager()
        .userMeneger
        .updateDbUser(field: DatabaseProvider.IMAGE, newWalue: image.path);

    if (error != null) {
      print(error);

      ///Show error
    }

    setState(() {});

    print(AppManager().userMeneger.user.profileImageUrl);
  }
}
