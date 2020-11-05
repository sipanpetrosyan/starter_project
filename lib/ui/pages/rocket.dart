import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';
import 'package:igroove_ui/models/star_game_model.dart';

class RocketPage extends StatefulWidget {
  @override
  _RocketPageState createState() => _RocketPageState();
}

class _RocketPageState extends State<RocketPage> with TickerProviderStateMixin {
  GlobalKey<_RocketPageState> stateWidgetKey = GlobalKey<_RocketPageState>();
  var random = new Random();
  List<double> arr = [];
  List<double> arr2 = [];

  List<StarGame> stars = [];

  ConstVariables constVariables = ConstVariables();

  StreamController<List<StarGame>> _starsDataUpdatStreamController =
      StreamController<List<StarGame>>.broadcast();
  double heightAppBar = AppBar().preferredSize.height;

  double xCordinat;
  double yCordinat;

  double starLeftTopDx;
  double starLeftTopDy;
  double starRightTopDx;
  double starRightTopDy;
  double starLeftBottomDx;
  double starLeftBottomDy;
  double starRightBottomDx;
  double starRightBottomDy;

  double rocketLeftTopDx = 100;
  double rocketLeftTopDy = 100;
  double rocketRightTopDx = 200;
  double rocketRightTopDy = 100;
  double rocketLeftBottomDx = 100;
  double rocketLeftBottomDy = 200;
  double rocketRightBottomDx = 200;
  double rocketRightBottomDy = 200;
  bool showDialoga = false;

  Timer starPositionUpdateTimer;
  Timer starCreatingTimer;
  @override
  void initState() {
    super.initState();
    createStarObjects();
    setStarAutoGeneration();
    setStarPositionUpdateTimer();
    _starsDataUpdatStreamController.stream.listen((value) {
      List<StarGame> closestStars = value.where((star) {
        bool dxCheck = star.dx > rocketRightTopDx
            ? star.dx - rocketRightTopDx < 20
            : rocketLeftTopDx - star.dx - 40 < 20;
        bool dyCheck =
            star.dy > 0 ? rocketLeftTopDy - (star.dy + 40) < 20 : false;
        bool dyCheckBottom =
            star.dy > 0 ? star.dy - rocketLeftBottomDy < 20 : false;

        return (dxCheck && dyCheck && dyCheckBottom);
        // || (dxCheckBottom && dyCheckBottom);
      }).toList();

      // print(closestStars);

      if (closestStars.isNotEmpty) {
        List<StarGame> closest = closestStars.where((closest) {
          // closestStars.
          bool dxGameOver = closest.dx > rocketRightTopDx
              ? closest.dx - rocketRightTopDx < 0
              : rocketLeftTopDx - closest.dx < 0;
          bool dyGameOver =
              closest.dy > 0 ? rocketLeftTopDy - (closest.dy + 40) < 0 : false;
          return dxGameOver && dyGameOver;
        }).toList();
        if (closest.isNotEmpty) {
          print('boom');
          starPositionUpdateTimer.cancel();
          starCreatingTimer.cancel();
          _starsDataUpdatStreamController.close();
          // showDialog(context);
          showDialoga = true;
          if (showDialoga) {
            showDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: new Text(
                        "Game Over",
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                      content: new Text("Want to play again?",
                          style: TextStyle(color: Colors.blue)),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          textStyle: TextStyle(fontWeight: FontWeight.normal),
                          // isDefaultAction: true,
                          child: Text('Yes'),
                          onPressed: () {},
                        ),
                        CupertinoDialogAction(
                          child: Text("No"),
                          textStyle: TextStyle(fontWeight: FontWeight.normal),
                          onPressed: () {
                            Navigator.of(context).pushNamed('products');
                          },
                        )
                      ],
                    ));
          }
          if (mounted) {
            setState(() {});
          }
        }
      }

      // for (int i = 0; i < closestStars.length; i++) {
      //   starLeftTopDx = value[i].dx;
      //   starLeftTopDy = value[i].dy;
      //   starRightTopDx = value[i].dx + 40;
      //   starRightTopDy = value[i].dy;
      //   starLeftBottomDx = value[i].dx;
      //   starLeftBottomDy = value[i].dy + 40;
      //   starRightBottomDx = value[i].dx + 40;
      //   starRightBottomDy = value[i].dy + 40;
      //   // print(starRightBottomDx - starLeftBottomDx);
      //   for (int j = 0; j < 40; j++) {
      //     if ((starRightBottomDy - j == rocketRightTopDy + j) &&
      //         starRightBottomDx - j == rocketRightTopDx - j) {
      //       print('boom x: $xCordinat, y: $yCordinat');
      //     }
      //   }
      //   if (mounted) {
      //     setState(() {});
      //   }
      // }
      // print('dx: ${value[1].dx}, dy: ${value[1].dy}');
      // print('length: ${value.length}');
      // if (mounted) {
      //   setState(() {});
      // }
    });
  }

  @override
  void didChangeDependencies() {
    // print(MediaQuery.of(context).padding.bottom);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    starPositionUpdateTimer.cancel();
    starCreatingTimer.cancel();
    _starsDataUpdatStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    // Offset a = Offset(1, 1);
    // Offset b = Offset(-1, -1);
    // Offset c = a - b;
    // print(c);
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Rocket'),
      ),
      body: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<StarGame>>(
            stream: _starsDataUpdatStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                // _starsDataUpdatStreamController.stream.listen((value) {
                //   print('Value from controller: $value');
                // });
                // print(snapshot.data.length);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ...List.generate(snapshot.data.length, (index) {
                      return AnimatedPositioned(
                        duration: Duration(milliseconds: 10),
                        top: snapshot.data[index].dy,
                        left: snapshot.data[index].dx,
                        child: snapshot.data[index].star,
                      );
                    }),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 10),
                      left: xCordinat,
                      top: yCordinat,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          rocketSpeed(details, topPadding);

                          // print('x: $xCordinat, y: $yCordinat');
                          // ));
                          // setState(() {}); dee
                        }, //
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 100,
                              width: 60,
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 60,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/rocket.png'))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return SizedBox();
            }),
      ),
    );
  }

  createStarObjects() {
    List<StarGame> starsRow = List.generate(3, (index) {
      return StarGame(
        dx: random.nextDouble() * (constVariables.screenWidth - 40),
        dy: -40,
        star: Icon(
          Icons.star,
          size: 40,
          color: Colors.yellow,
        ),
      );
    });

    stars.removeWhere((star) => !star.isVisible);

    stars.addAll(starsRow);
  }

  setStarAutoGeneration() {
    starCreatingTimer = Timer.periodic(Duration(milliseconds: 15700), (timer) {
      createStarObjects();
    });
  }

  setStarPositionUpdateTimer() {
    starPositionUpdateTimer =
        Timer.periodic(Duration(milliseconds: 300), (timer) {
      _starsDataUpdatStreamController.sink.add(stars);
    });
  }

  rocketSpeed(details, topPadding) {
    xCordinat = details.globalPosition.dx - 30;
    yCordinat = details.globalPosition.dy - heightAppBar - topPadding;
    rocketLeftTopDx = xCordinat - 30;
    rocketLeftTopDy = yCordinat;
    rocketRightTopDx = xCordinat + 30;
    rocketRightTopDy = yCordinat;
    rocketLeftBottomDx = xCordinat - 30;
    rocketLeftBottomDy = yCordinat + 60;
    rocketRightBottomDx = xCordinat + 30;
    rocketLeftBottomDy = yCordinat + 60;

    // if (yCordinat.toInt() >= starRightBottomDx.toInt()) {
    //   print(5);
    // } else {
    //   print(5555555555555);
    // }
    // print('star: $starLeftTopDx');
    // print('xCordinat: $xCordinat, rocketLeftTopDx: $rocketLeftTopDx');
  }
  // showDialog() {
  //   context: context,
  //     barrierDismissible: true,
  //     barrierLabel: MaterialLocalizations.of(context)
  //         .modalBarrierDismissLabel,
  //     barrierColor: Colors.black45,
  //     transitionDuration: const Duration(milliseconds: 200),
  //     pageBuilder: (BuildContext buildContext,
  //         Animation animation,
  //         Animation secondaryAnimation) {
  //       return Center(
  //         child: Container(
  //           width: MediaQuery.of(context).size.width - 10,
  //           height: MediaQuery.of(context).size.height -  80,
  //           padding: EdgeInsets.all(20),
  //           color: Colors.white,
  //           child: Column(
  //             children: [
  //               RaisedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   "Save",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 color: const Color(0xFF1BC0C5),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     }
  // }
}
