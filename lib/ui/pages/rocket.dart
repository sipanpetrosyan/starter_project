import 'dart:async';
import 'dart:math';

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
      StreamController<List<StarGame>>();
  double coordinateX;
  double coordinateY;

  double xCordinat;
  double yCordinat;

  Timer starPositionUpdateTimer;
  Timer starCreatingTimer;
  @override
  void initState() {
    coordinateX = ((constVariables.screenWidth - 100) / 200);
    coordinateY = ((constVariables.screenHeight - 200) / 200);
    createStarObjects();
    setStarAutoGeneration();
    setStarPositionUpdateTimer();
    super.initState();
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
    // Offset a = Offset(1, 1);
    // Offset b = Offset(-1, -1);
    // Offset c = a - b;
    // print(c);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<StarGame>>(
            stream: _starsDataUpdatStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
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
                          xCordinat = details.globalPosition.dx - 50;
                          yCordinat = details.globalPosition.dy;
                          // print('x: $xCordinat, y: $yCordinat');
                          // ));
                          // setState(() {});
                        },
                        child: Image(
                          height: 100,
                          width: 100,
                          image: AssetImage('assets/images/rocket.png'),
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
    starCreatingTimer = Timer.periodic(Duration(milliseconds: 1700), (timer) {
      createStarObjects();
    });
  }

  setStarPositionUpdateTimer() {
    starPositionUpdateTimer =
        Timer.periodic(Duration(milliseconds: 10), (timer) {
      _starsDataUpdatStreamController.add(stars);
    });
  }
}
