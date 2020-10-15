import 'package:flutter/material.dart';
import 'dart:math' as math;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  bool animationZero = false;
  bool animationOne = false;
  bool animationTwo = false;
  bool animationThree = false;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    animationZero = true;
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.5, 3.0),
      end: Offset(0.0, 3.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));
    // setState(() {});
    _controller.forward().then((value) {
      animationOne = true;
      _controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
      );
      _offsetAnimation = Tween<Offset>(
        begin: _offsetAnimation.value,
        end: Offset(
            _offsetAnimation.value.dx + 3, _offsetAnimation.value.dy - 3),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ));

      setState(() {});

      _controller.forward().then((value) {
        animationTwo = true;
        _controller = AnimationController(
          duration: Duration(seconds: 2),
          vsync: this,
        );
        _offsetAnimation = Tween<Offset>(
          begin: _offsetAnimation.value,
          end: Offset(_offsetAnimation.value.dx - 3, _offsetAnimation.value.dy),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ));
        setState(() {});

        _controller.forward().then((value) {
          animationThree = true;
          _controller = AnimationController(
            duration: Duration(seconds: 2),
            vsync: this,
          );
          _offsetAnimation = Tween<Offset>(
            begin: _offsetAnimation.value,
            end: Offset(
                _offsetAnimation.value.dx + 3, _offsetAnimation.value.dy + 3),
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.ease,
          ));
          setState(() {});
          _controller.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SlideTransition(
          position: _offsetAnimation,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(animationOne
                ? (!animationTwo ? 45 : !animationThree ? -90 : 135) / 360
                : -90 / 360),
            child: Image(
              height: 100,
              width: 100,
              image: AssetImage('assets/images/rocket.png'),
            ),
          ),
          // child: animationOne == false
          //     ? Image(
          //         height: 100,
          //         width: 100,
          //         image: AssetImage('assets/images/rocket.png'),
          //       )
          //     : RotationTransition(
          //         turns: AlwaysStoppedAnimation(45 / 360),
          //         child: Image(
          //           height: 100,
          //           width: 100,
          //           image: AssetImage('assets/images/rocket.png'),
          //         ),
          //       )

          // Image(
          //   height: 100,
          //   width: 100,
          //   image: AssetImage('assets/images/newwave-logo-icon.png'),
          // ),
        ),
      ),
    );
  }
}
