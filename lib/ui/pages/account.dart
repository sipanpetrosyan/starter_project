import 'package:flutter/material.dart';
import 'dart:math' as math;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  bool animationOne = false;
  bool animationTwo = false;
  bool animationThree = false;
  bool animationFour = false;
  bool animationFive = false;
  bool animationSix = false;
  bool animationSeven = false;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
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

          _controller.forward().then((value) {
            animationFour = true;
            _controller = AnimationController(
              duration: Duration(seconds: 2),
              vsync: this,
            );
            _offsetAnimation = Tween<Offset>(
              begin: _offsetAnimation.value,
              end: Offset(
                  _offsetAnimation.value.dx - 1.5, _offsetAnimation.value.dy),
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.ease,
            ));
            setState(() {});

            _controller.forward().then((value) {
              animationFive = true;
              _controller = AnimationController(
                duration: Duration(seconds: 2),
                vsync: this,
              );
              _offsetAnimation = Tween<Offset>(
                begin: _offsetAnimation.value,
                end: Offset(_offsetAnimation.value.dx - 1.5,
                    _offsetAnimation.value.dy + 2),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.ease,
              ));
              setState(() {});

              _controller.forward().then((value) {
                animationSix = true;
                _controller = AnimationController(
                  duration: Duration(seconds: 2),
                  vsync: this,
                );
                _offsetAnimation = Tween<Offset>(
                  begin: _offsetAnimation.value,
                  end: Offset(
                      _offsetAnimation.value.dx + 3, _offsetAnimation.value.dy),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.ease,
                ));
                setState(() {});

                _controller.forward().then((value) {
                  animationSeven = true;
                  _controller = AnimationController(
                    duration: Duration(seconds: 2),
                    vsync: this,
                  );
                  _offsetAnimation = Tween<Offset>(
                    begin: _offsetAnimation.value,
                    end: Offset(_offsetAnimation.value.dx - 1.5,
                        _offsetAnimation.value.dy - 2),
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Curves.ease,
                  ));
                  setState(() {});

                  _controller.forward().then((value) {
                    animationSeven = true;
                    _controller = AnimationController(
                      duration: Duration(seconds: 1),
                      vsync: this,
                    )..repeat(reverse: true);
                    _offsetAnimation = Tween<Offset>(
                      begin: _offsetAnimation.value,
                      end: Offset(
                          _offsetAnimation.value.dx, _offsetAnimation.value.dy),
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.elasticOut,
                    ));
                    setState(() {});
                    // _controller.forward();
                  });
                });
              });
            });
          });
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
                ? (!animationTwo
                        ? 45
                        : !animationThree
                            ? -90
                            : !animationFour
                                ? 135
                                : !animationFive
                                    ? -90
                                    : !animationSix
                                        ? -135
                                        : !animationSeven ? 90 : -45) /
                    360
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
