import 'package:flutter/widgets.dart';

class ConstVariables {
  static ConstVariables _singleton;
  final BuildContext context;

  factory ConstVariables({BuildContext context}) {
    if (_singleton == null) {
      _singleton = ConstVariables._internal(context);
    }

    return _singleton;
  }

  ConstVariables._internal(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}
