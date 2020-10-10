import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ConstVariables constVariables = ConstVariables();
  File _image;
  int _value = 1;
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
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color.fromARGB(255, 244, 129, 79),
                    fontFamily: "Montserrat",
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
                        child: _image != null
                            ? ClipRRect(
                                child: Image.file(
                                  _image,
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
                          onTap: () {
                            print('Email');
                            FocusScope.of(context).unfocus();
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
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.chevron_right),
                              ],
                            ),
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
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.chevron_right),
                              ],
                            ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _value,
                            items: [
                              DropdownMenuItem(
                                  child: Text("English",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  value: 1),
                              DropdownMenuItem(
                                  child: Text("Russian",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  value: 2),
                              DropdownMenuItem(
                                  child: Text("Armenian",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  value: 3)
                            ],
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            }),
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

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }
}
