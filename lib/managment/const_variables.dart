import 'package:flutter/widgets.dart';
import 'package:igroove_ui/base/app_keys.dart';

class ConstVariables {
  static ConstVariables _singleton;
  final BuildContext context = AppKeys.navigatorKey.currentContext;

  factory ConstVariables() {
    if (_singleton == null) {
      _singleton = ConstVariables._internal();
    }

    return _singleton;
  }

  ConstVariables._internal();

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}
