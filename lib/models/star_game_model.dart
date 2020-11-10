import 'dart:async';

import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/const_variables.dart';

class StarGame {
  DateTime _createdDate;

  ConstVariables _constVariables = ConstVariables();

  Widget star;

  double dx;
  double dy;

  StarGame({this.dx, this.dy, this.star}) {
    _createdDate = DateTime.now();
    updatePosition();
  }

  bool get isVisible =>
      DateTime.now().difference(this._createdDate).inMilliseconds <
      (_constVariables.screenHeight * 12);

  bool hasOverlapping(Offset offset) {
    RenderBox renderBox =
        (star.key as GlobalKey).currentContext.findRenderObject();

    double starWidth = renderBox.size.width;
    double starHeight = renderBox.size.height;

    bool hasOverlaping = false;

    if ((offset.dx > this.dx || offset.dx < this.dx + starWidth) &&
        (offset.dy > this.dy || offset.dy < this.dy + starHeight)) {
      hasOverlaping = true;
    }

    return hasOverlaping;
  }

  updatePosition() {
    Timer.periodic(Duration(milliseconds: 12), (timer) {
      this.dy += 1;
    });
  }
}
