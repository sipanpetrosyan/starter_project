import 'package:igroove_ui/managment/user.dart';

class AppManager {
  static AppManager _singlton;

  AppManager._internal();
  factory AppManager() {
    if (_singlton == null) {
      _singlton = AppManager._internal();
    }
    return _singlton;
  }

  UserMeneger userMeneger = UserMeneger();
}
