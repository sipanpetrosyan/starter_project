import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/http_example.dart';
import 'package:igroove_ui/ui/pages/http_image.dart';
import 'package:igroove_ui/ui/pages/post_request.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ConstVariables constVariables = ConstVariables();
  double _volume = 0.0;
  String dropdownValue = 'One';
  static List<String> dropdownLengList = ['English', 'Russian', 'Armenian'];
  String selectLenguage = dropdownLengList[0];
  int group = 1;
  bool oneChackBoxValue = false;
  bool twoChackBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: bodyContent(),
        // FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget bodyContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('1:'),
                ),
                // OutlineButton
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HttpPage()));
                    print('Received click');
                  },
                  child: Text('Click Me'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('OutlineButton Get'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('2:'),
                ),
                // FlatButton
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HttpImagePage()));
                  },
                  child: Text(
                    "Flat Button",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('FlatButton Get'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('3:'),
                ),
                // IconButton
                IconButton(
                  icon: Icon(Icons.volume_up),
                  tooltip: 'Increase volume by 10',
                  onPressed: () {
                    setState(() {
                      _volume += 10;
                    });
                  },
                ),
                Text('Volume : $_volume'),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('IconButton'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('4:'),
                ),
                // DropdownButton
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('DropdownButton'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('5:'),
                ),
                // RaisedButton
                Column(
                  children: [
                    RaisedButton(
                      onPressed: null,
                      child: Text('Disabled Button',
                          style: TextStyle(fontSize: 20)),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: const Text('Enabled Button',
                          style: TextStyle(fontSize: 20)),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Gradient Button',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('RaisedButton'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('6:'),
                ),
                // PopupMenuButton
                PopupMenuButton<int>(
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
                      width: constVariables.screenWidth * 0.4,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 2.0,
                              color: Color.fromARGB(255, 220, 220, 220)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('PopupMenuButton'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('7:'),
                ),
                // ButtonBar
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      color: Colors.blue,
                      onPressed: () {/** */},
                    ),
                    FlatButton(
                      child: Text('Cancel'),
                      color: Colors.blue,
                      onPressed: () {/** */},
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('ButtonBar'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('8:'),
                ),
                // MaterialButton
                MaterialButton(
                  minWidth: 150.0,
                  height: 35,
                  color: Color(0xFF801E48),
                  child: new Text('Material Button',
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PostRequestPage()));
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('MaterialButton Post'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('9:'),
                ),
                // RadioButton
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: group,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setState(() {
                              group = val;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              group = 1;
                            });
                          },
                          child: Text("one"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: group,
                          activeColor: Colors.green,
                          onChanged: (val) {
                            print("Radio $val");
                            setState(() {
                              group = val;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              group = 2;
                            });
                          },
                          child: Text('two'),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('RadioButton'),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('10:'),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: oneChackBoxValue,
                          onChanged: (bool value) {
                            print(value);
                            setState(() {
                              oneChackBoxValue = value;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              oneChackBoxValue = !oneChackBoxValue;
                            });
                          },
                          child: Text("one"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: twoChackBoxValue,
                          onChanged: (bool value) {
                            print(value);
                            setState(() {
                              twoChackBoxValue = value;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              twoChackBoxValue = !twoChackBoxValue;
                            });
                          },
                          child: Text("two"),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('chackBox'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
