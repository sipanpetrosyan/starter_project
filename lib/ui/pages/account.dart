import 'dart:math';

import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  AnimationController _controllerSlide;
  AnimationController _controllerSlideTwo;
  Animation<Offset> _offsetAnimation;
  Animation<Offset> _offsetAnimationTwo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controllerSlide = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerSlide,
      curve: Curves.bounceOut,
    ));

    _controllerSlideTwo = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimationTwo = Tween<Offset>(
      begin: Offset(1.0, 0.5),
      end: const Offset(0.0, 2.0),
    ).animate(CurvedAnimation(
      parent: _controllerSlideTwo,
      curve: Curves.linearToEaseOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerSlide.dispose();
    _controllerSlideTwo.dispose();

    super.dispose();
  }

  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  bool selected = false;
  bool switchChild = true;
  // double padding = 100.0;
  bool isChanging = false;
  bool _first = true;
  double _left = 20;
  double _top = 20;
  double _right = 20;
  double _bottom = 20;
  @override
  Widget build(BuildContext context) {
    // print('one $isChanging - two - $switchChild  ');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              slideTransition(),
              slideTransitionTwo(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('1: '),
                  ),
                  rotationTransition(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('2: '),
                  ),
                  animationController(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('3: '),
                  ),
                  animatedContainer(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('4: '),
                  ),
                  animatedCrossFade(),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('5: '),
                  ),
                  shadowContent(),
                ],
              ),
              animatedSwitcher(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('6: '),
                  ),
                  animatedPositioned(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget slideTransitionTwo() {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
      alignment: Alignment.centerLeft,
      width: 100,
      height: 100,
      child: SlideTransition(
        position: _offsetAnimationTwo,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(size: 100.0),
        ),
      ),
    );
  }

  Widget slideTransition() {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
      alignment: Alignment.centerLeft,
      width: 100,
      height: 100,
      child: SlideTransition(
        position: _offsetAnimation,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(size: 150.0),
        ),
      ),
    );
  }

  Widget rotationTransition() {
    return Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
      alignment: Alignment.centerLeft,
      width: 100,
      height: 100,
      child: RotationTransition(
        turns: _animation,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: FlutterLogo(size: 150.0),
        ),
      ),
    );
  }

  Widget animationController() {
    return Column(
      children: [
        Center(
          child: RaisedButton(
            child: Text('Click me'),
            onPressed: () {
              setState(() {
                final random = Random();

                // Generate a random width and height.
                _width = random.nextInt(300).toDouble();
                _height = random.nextInt(300).toDouble();

                // Generate a random color.
                _color = Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  1,
                );

                // Generate a random border radius.
                _borderRadius =
                    BorderRadius.circular(random.nextInt(100).toDouble());
              });
            },
          ),
        ),
        AnimatedContainer(
          // Use the properties stored in the State class.
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          // Define how long the animation should take.
          duration: Duration(seconds: 1),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
        ),
      ],
    );
  }

  Widget animatedContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: FlutterLogo(size: 75),
        ),
      ),
    );
  }

  Widget animatedCrossFade() {
    return Column(
      children: [
        Center(
          child: RaisedButton(
            child: Text('Click me'),
            onPressed: () {
              setState(() {
                isChanging = !isChanging;
              });
            },
          ),
        ),
        Center(
          child: AnimatedCrossFade(
            firstChild: FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 100.0,
            ),
            secondChild: FlutterLogo(
              style: FlutterLogoStyle.stacked,
              size: 100.0,
            ),
            crossFadeState: isChanging
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(seconds: 2),
          ),
        ),
      ],
    );
  }

  Widget shadowContent() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(30),
          height: 150,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            "Box Shadow on Container",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget animatedSwitcher() {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.pink,
      Colors.blue,
      Colors.amber,
      Colors.deepPurple
    ];
    Random random = Random();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: OutlineButton(
            onPressed: () {
              setState(() {
                switchChild = !switchChild;
              });
            },
            child: Text('Click Me'),
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(seconds: 3),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: switchChild
              ? Container(
                  key: ValueKey(1),
                  height: 100,
                  width: 100,
                  color: colors[random.nextInt(colors.length)],
                )
              : Container(
                  key: ValueKey(2),
                  height: 150,
                  width: 150,
                  color: colors[random.nextInt(colors.length)],
                ),
        ),
      ],
    );
  }

  Widget animatedPositioned() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                left: _left,
                top: _top,
                right: _right,
                bottom: _bottom,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          child: const Text('CLICK ME'),
          onPressed: () {
            setState(() {
              _left = _first ? 10 : 30;
              _top = _first ? 80 : 30;
              _right = _first ? 10 : 30;
              _bottom = _first ? 80 : 30;
              _first = !_first;
            });
          },
        ),
      ],
    );
  }
}
