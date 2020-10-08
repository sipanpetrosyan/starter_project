import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/widgets/date_periods_dialog.dart';
import 'package:igroove_ui/widgets/expansion_tile_custom.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class MyTrends extends StatefulWidget {
  @override
  _MyTrendsState createState() => _MyTrendsState();
}

class _MyTrendsState extends State<MyTrends> {
  int selectedTab = 0;
  bool iconClick = true;
  ConstVariables constVariables;
  GlobalKey _globalKey = GlobalKey();
  GlobalKey _globalKeyReleases = GlobalKey();
  GlobalKey<CustomExpansionTileState> _expansionTileKey =
      GlobalKey<CustomExpansionTileState>();

  List<String> listItems = [
    'This week',
    'Last 30 days',
    'Last month',
    'Last 3 months',
    'Since beginning',
    'Select period'
  ];

  List<String> listReleases = [
    'Top Releases',
    'Top Songs',
    'Top Artists',
    'Top Stores',
    'Top Countries',
    'Top Types'
  ];
  String titleReleases;
  int indexDropdown;
  int indexDateDrop;

  @override
  void initState() {
    indexDateDrop = 1;
    indexDropdown = 0;
    titleReleases = listReleases[0];

    super.initState();
  }

  List<String> mountList = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static DateTime nowDate = DateTime.now();
  int nowDay = nowDate.day;
  int nowMonth = nowDate.month;
  int nowYear = nowDate.year;
  int oldDay = nowDate.day + 1;
  int oldMonth = (nowDate.month != 1) ? nowDate.month - 1 : 12;
  int oldYear = (nowDate.month == 1 && nowDate.day < 30)
      ? nowDate.year - 1
      : nowDate.year;

  Size _getSizes() {
    final RenderBox renderBoxTop = _globalKey.currentContext.findRenderObject();
    final sizeTop = renderBoxTop.size;
    // print("SIZE of Top: $sizeTop");
    return sizeTop;
  }

  Offset _getPositions() {
    final RenderBox renderBoxTop = _globalKey.currentContext.findRenderObject();
    final positionTop = renderBoxTop.localToGlobal(Offset.zero);
    // print("ПОЛОЖЕНИЕ Top: $positionTop");
    return positionTop;
  }

  Size _getSizesReleases() {
    final RenderBox renderBoxTop =
        _globalKeyReleases.currentContext.findRenderObject();
    final sizeTop = renderBoxTop.size;
    // print("SIZE of Top: $sizeTop");
    return sizeTop;
  }

  Offset _getPositionsReleases() {
    final RenderBox renderBoxTop =
        _globalKeyReleases.currentContext.findRenderObject();
    final positionTop = renderBoxTop.localToGlobal(Offset.zero);
    // print("ПОЛОЖЕНИЕ Top: $positionTop");
    return positionTop;
  }

  var data = [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    constVariables = ConstVariables(context: context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(),
          body: trendsBody(),
        ),
      ),
    );
  }

  Widget trendsBody() {
    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
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
              child: dropdownDate(),
            ),
            Stack(
              children: [
                blackBlock(),
                Positioned(
                  top: 125,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constVariables.screenWidth * 0.05),
                    child: dropdownReleases(),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constVariables.screenWidth * 0.05, vertical: 0),
                child: customExpansionTileWidget())
          ],
        ),
      ),
    );
  }

  Widget dropdownDate() {
    return GestureDetector(
      onTap: () {
        userShowDialog(1);
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
                  '$oldDay. ${mountList[oldMonth]} $oldYear - $nowDay. ${mountList[nowMonth]} $nowYear',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Color.fromARGB(255, 244, 129, 79),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget blackBlock() {
    return Container(
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
                  color: Colors.white, fontSize: 30, fontFamily: "Montserrat"),
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
    );
  }

  Widget dropdownReleases() {
    return Container(
      width: constVariables.screenWidth * 0.9,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          key: _globalKeyReleases,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                userShowDialog(2);
              },
              child: Row(
                children: [
                  Text(
                    titleReleases ?? "",
                    style: TextStyle(
                        color: Color.fromARGB(255, 244, 129, 79), fontSize: 17),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 244, 129, 79),
                    size: 20,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (iconClick != true) {
                    _expansionTileKey.currentState.collapse();
                  } else {
                    _expansionTileKey.currentState.expand();
                  }
                });
              },
              child: Icon(
                (iconClick == true)
                    ? Icons.broken_image
                    : Icons.format_list_bulleted,
                color: Color.fromARGB(255, 244, 129, 79),
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customExpansionTileWidget() {
    return CustomExpansionTile(
      key: _expansionTileKey,
      tilePadding: EdgeInsets.zero,
      onExpansionChanged: (value) {
        setState(() {
          iconClick = !value;
        });
      },
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 229, 229, 229)),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Stream',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CHF 0.01',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '100 %',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: "Montserrat",
                        fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 5),
          child: Container(
            height: 50,
            child: Sparkline(
              lineColor: Color.fromARGB(255, 244, 129, 79),
              data: data,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Streams:',
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 13),
                    ),
                    Text('3')
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Downloads:',
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 13),
                    ),
                    Text('0')
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cd:',
                      style: TextStyle(fontFamily: "Montserrat", fontSize: 13),
                    ),
                    Text('0')
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    iconClick = !iconClick;
                    _expansionTileKey.currentState.collapse();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Close', style: TextStyle(color: Colors.grey)),
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  userShowDialog(numberDialog) {
    var getPosition =
        (numberDialog == 1) ? _getPositions().dy : _getPositionsReleases().dy;
    var getSize =
        (numberDialog == 1) ? _getSizes().height : _getSizesReleases().height;
    double position =
        (getPosition - MediaQuery.of(context).padding.top + getSize);
    double rightPadding = (numberDialog == 1)
        ? constVariables.screenWidth * 0.3
        : constVariables.screenWidth * 0.5;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        int count =
            (numberDialog == 1) ? listItems.length : listReleases.length;
        return DatePeriodsDialog(
          position: position,
          rightPadding: rightPadding,
          itemBuilder: (context, index) {
            String title =
                (numberDialog == 1) ? listItems[index] : listReleases[index];

            bool checkDialogsSelected = (numberDialog == 1
                ? indexDateDrop == index
                : indexDropdown == index);
            return Container(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // print('index2- ${index}');
                  Navigator.of(context).pop(index);

                  if (numberDialog == 1 && index == 0) {
                    _lastWeekDate();
                  } else if (numberDialog == 1 && index == 1) {
                    _lastThirtyDate();
                  } else if (numberDialog == 1 && index == 2) {
                    _lastMountDate();
                  } else if (numberDialog == 1 && index == 3) {
                    _lastThreeMount();
                  } else if (numberDialog == 1 && index == 4) {
                    _lastBeginning();
                  } else if (numberDialog == 1 && index == count - 1) {
                    _dataPickerDialog(context);
                  }

                  setState(() {
                    numberDialog == 1
                        ? indexDateDrop = index
                        : indexDropdown = index;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkDialogsSelected
                        ? Icon(
                            Icons.done,
                            color: Color.fromARGB(255, 244, 129, 79),
                          )
                        : SizedBox(
                            width: 24,
                            height: 24,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              '$title',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: !checkDialogsSelected
                                      ? Colors.black
                                      : Color.fromARGB(255, 244, 129, 79)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: count,
        );
      },
    ).then((val) {
      setState(() {
        // print('index dropdown: $val');
        if (val != null) {
          if (numberDialog == 1) {
            indexDateDrop = val;
          } else {
            indexDropdown = val;
            titleReleases = listReleases[val];
          }
          // print('title ```  $titleReleases');
          // print('indexDateDrop: $indexDateDrop, indexDropdown: $indexDropdown');
        }
      });
    });
  }

  _lastWeekDate() {
    int testDay = nowDate.day - 7;
    DateTime x1 = DateTime(nowDate.year, nowMonth, 0).toUtc();
    var dayMount =
        DateTime(nowDate.year, nowMonth + 1, 0).toUtc().difference(x1).inDays;
    print(dayMount);
    var monday = 1;
    var nowd = new DateTime.now();

    while (nowd.weekday != monday) {
      nowd = nowd.subtract(new Duration(days: 1));
    }

    print('Recent monday $nowd');
    oldDay =
        testDay < 0 ? dayMount + testDay : nowDate.day - DateTime.now().weekday;
    oldMonth = testDay < 0 ? nowDate.month - 1 : nowDate.month;
    oldYear = (nowDate.month == 1 && nowDate.day < 8)
        ? nowDate.year - 1
        : nowDate.year;
    nowDay = nowDate.day;
    nowMonth = nowDate.month;
    nowYear = nowDate.year;
    print(DateTime.now().weekday);
  }

  _lastThirtyDate() {
    oldDay = nowDate.day + 1;
    oldMonth = (nowDate.month != 1) ? nowDate.month - 1 : 12;
    oldYear = (nowDate.month == 1 && nowDate.day < 30)
        ? nowDate.year - 1
        : nowDate.year;
    nowDay = nowDate.day;
    nowMonth = nowDate.month;
    nowYear = nowDate.year;
  }

  _lastMountDate() {
    DateTime x1 = DateTime(nowDate.year, oldMonth, 0).toUtc();
    var dayMount =
        DateTime(nowDate.year, oldMonth + 1, 0).toUtc().difference(x1).inDays;
    print(dayMount);
    oldDay = 1;
    oldMonth = (nowDate.month != 1) ? nowDate.month - 1 : 12;
    oldYear = (nowDate.month == 1) ? nowDate.year - 1 : nowDate.year;
    nowDay = dayMount;
    nowMonth = (nowDate.month != 1) ? nowDate.month - 1 : 12;
    nowYear = (nowDate.month == 1) ? nowDate.year - 1 : nowDate.year;
  }

  _lastThreeMount() {
    DateTime x1 = DateTime(nowDate.year, oldMonth, 0).toUtc();
    var dayMount =
        DateTime(nowDate.year, oldMonth + 1, 0).toUtc().difference(x1).inDays;
    print(dayMount);
    oldDay = 1;
    oldMonth = (nowDate.month != 1) ? nowDate.month - 3 : 12;
    oldYear = (nowDate.month == 1) ? nowDate.year - 1 : nowDate.year;
    nowDay = dayMount;
    nowMonth = (nowDate.month != 1) ? nowDate.month - 1 : 12;
    nowYear = (nowDate.month == 1) ? nowDate.year - 1 : nowDate.year;
  }

  _lastBeginning() {
    var date = DateTime.fromMicrosecondsSinceEpoch(0);
    oldDay = date.day;
    oldMonth = date.month;
    oldYear = date.year;
    nowDay = nowDate.day;
    nowMonth = nowDate.month;
    nowYear = nowDate.year;
  }

  _dataPickerDialog(context) {
    DateTime now = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}
