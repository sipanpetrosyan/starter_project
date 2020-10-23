import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:igroove_ui/managment/const_variables.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<double> _animation;
  var random = new Random();
  List<double> arr = [];
  List<double> arr2 = [];
  Map<String, List> map1 = {};

  ConstVariables constVariables = ConstVariables();

  Timer timer;
  @override
  void initState() {
    // arr.add(random.nextDouble() * constVariables.screenWidth);

    Map<String, List> map1 = {'x': arr, 'y': arr2};
    // print('arr $arr');
    print('arr $map1');
    super.initState();
    animationBuilder();
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {});
      animationBuilder();
    });
  }

  @override
  void didChangeDependencies() {
    print(MediaQuery.of(context).padding.bottom);
    List<String>.generate(10, (counter) {
      arr.add(random.nextDouble() * (constVariables.screenWidth - 40));
      arr2.add(random.nextDouble() *
          (constVariables.screenHeight -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              56 -
              40));
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
  
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(arr.length, (index) {
              return Positioned(
                top: arr2[index],
                left: arr[index],
                child: Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.yellow,
                ),
              );
            }),
            SlideTransition(
              position: _offsetAnimation,
              child: RotationTransition(
                turns: _animation,
                child: Image(
                  height: 100,
                  width: 100,
                  image: AssetImage('assets/images/rocket.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  animationBuilder() {
    double coordinateX = ((constVariables.screenWidth - 100) / 200);
    double coordinateY = ((constVariables.screenHeight - 200) / 200);

    _animation = AlwaysStoppedAnimation(-90 / 360);
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(-coordinateX, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _controller.forward().then((value) {
      _animation = AlwaysStoppedAnimation(45 / 360);
      _controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
      );
      _offsetAnimation = Tween<Offset>(
        begin: _offsetAnimation.value,
        end: Offset(coordinateX, -coordinateY),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ));

      if (mounted) {
        setState(() {});
      }

      _controller.forward().then((value) {
        _animation = AlwaysStoppedAnimation(-90 / 360);
        _controller = AnimationController(
          duration: Duration(seconds: 1),
          vsync: this,
        );
        _offsetAnimation = Tween<Offset>(
          begin: _offsetAnimation.value,
          end: Offset(-coordinateX, -coordinateY),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ));
        if (mounted) {
          setState(() {});
        }

        _controller.forward().then((value) {
          _animation = AlwaysStoppedAnimation(135 / 360);
          _controller = AnimationController(
            duration: Duration(seconds: 1),
            vsync: this,
          );
          _offsetAnimation = Tween<Offset>(
            begin: _offsetAnimation.value,
            end: Offset(coordinateX, 0),
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.ease,
          ));
          if (mounted) {
            setState(() {});
          }

          _controller.forward().then((value) {
            _animation = AlwaysStoppedAnimation(-135 / 360);
            _controller = AnimationController(
              duration: Duration(seconds: 1),
              vsync: this,
            );
            _offsetAnimation = Tween<Offset>(
              begin: _offsetAnimation.value,
              end: Offset(-coordinateX, coordinateY),
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.ease,
            ));
            if (mounted) {
              setState(() {});
            }

            _controller.forward().then((value) {
              _animation = AlwaysStoppedAnimation(90 / 360);
              _controller = AnimationController(
                duration: Duration(seconds: 1),
                vsync: this,
              );
              _offsetAnimation = Tween<Offset>(
                begin: _offsetAnimation.value,
                end: Offset(coordinateX, coordinateY),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.ease,
              ));
              if (mounted) {
                setState(() {});
              }

              _controller.forward().then((value) {
                _animation = AlwaysStoppedAnimation(-45 / 360);
                _controller = AnimationController(
                  duration: Duration(seconds: 1),
                  vsync: this,
                );
                _offsetAnimation = Tween<Offset>(
                  begin: _offsetAnimation.value,
                  end: Offset(-coordinateX, 0),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.ease,
                ));
                if (mounted) {
                  setState(() {});
                }

                _controller.forward().then((value) {
                  _animation = AlwaysStoppedAnimation(90 / 360);
                  _controller = AnimationController(
                    duration: Duration(seconds: 1),
                    vsync: this,
                  );
                  _offsetAnimation = Tween<Offset>(
                    begin: _offsetAnimation.value,
                    end: Offset(0, 0),
                  ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: Curves.ease,
                  ));
                  if (mounted) {
                    setState(() {});
                  }

                  _controller.forward().then((value) {
                    _controller = AnimationController(
                      duration: Duration(seconds: 2),
                      vsync: this,
                    );
                    _animation = CurvedAnimation(
                      parent: _controller,
                      curve: Curves.elasticOut,
                    );
                    setState(() {});

                    _controller.forward();
                  });
                });
              });
            });
          });
        });
      });
    });
  }
}
