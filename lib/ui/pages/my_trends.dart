import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/ui/pages/widget/date_periods_dialog.dart';

class MyTrends extends StatefulWidget {
  @override
  _MyTrendsState createState() => _MyTrendsState();
}

class _MyTrendsState extends State<MyTrends> {
  int selectedTab = 0;
  ConstVariables constVariables;

  GlobalKey _globalKey = GlobalKey();

  List<String> listItems = [
    'This week',
    'Last 30 days',
    'Last month',
    'Last 3 months',
    'Since beginning',
    'Select period'
  ];

  @override
  void initState() {
    super.initState();
  }

  Size _getSizes() {
    final RenderBox renderBoxRed = _globalKey.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
    return sizeRed;
  }

  Offset _getPositions() {
    final RenderBox renderBoxRed = _globalKey.currentContext.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("ПОЛОЖЕНИЕ красного: $positionRed");

    return positionRed;
  }

  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables(context: context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromARGB(255, 242, 113, 58),
            unselectedItemColor: Color.fromARGB(255, 99, 99, 105),
            showUnselectedLabels: true,
            unselectedFontSize: 13,
            selectedFontSize: 13,
            elevation: 0,
            currentIndex: selectedTab,
            onTap: (index) {
              setState(() {
                selectedTab = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Text(
                  'Trends',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.equalizer),
              ),
              BottomNavigationBarItem(
                title: Text(
                  'Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.account_balance_wallet),
              ),
              BottomNavigationBarItem(
                title: Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.music_video),
              ),
              BottomNavigationBarItem(
                title: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          body: trendsBody(),
        ),
      ),
    );
  }

  Widget trendsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 10),
            child: Text(
              'My Trends',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: constVariables.screenWidth * 0.05,
              right: constVariables.screenWidth * 0.05,
              bottom: 20,
            ),
            child: GestureDetector(
              onTap: () {
                // _showDialog();
                userShowDialog();
              },
              child: Container(
                key: _globalKey,
                width: constVariables.screenWidth * 0.9,
                height: 26,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Center(
                            child: Icon(
                              Icons.calendar_today,
                              size: 17,
                              color: Color.fromARGB(255, 244, 129, 79),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                          child: Text(
                        '1.Juli 2019 - 30. Aug 2019',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Color.fromARGB(255, 244, 129, 79),
                        ),
                      )),
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
                height: 170,
                color: Color.fromARGB(255, 33, 31, 34),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Text(
                        "CHF 18'295.30",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Montserrat"),
                      ),
                      Text(
                        "CHF 1163.40(+9.7%)",
                        style: TextStyle(
                          color: Color.fromARGB(255, 164, 162, 164),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 125,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: constVariables.screenWidth * 0.05),
                  child: Container(
                    width: constVariables.screenWidth * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  userShowDialog() {
    // print("Top padding: ${MediaQuery.of(context).padding.top}");
    var a = _getPositions().dy;
    double position = (_getPositions().dy -
        MediaQuery.of(context).padding.top +
        _getSizes().height);
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return DatePeriodsDialog(
          listItems,
          position: position,
        );
      },
    );
  }

  Widget _datePickerDialog() {
    DateTime now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {});
  }
}
