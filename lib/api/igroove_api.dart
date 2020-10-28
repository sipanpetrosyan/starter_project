import 'package:igroove_ui/api/user/user.dart';

class AppAPI {
  static AppAPI _singleton;

  factory AppAPI() {
    if (_singleton == null) {
      _singleton = AppAPI._private();
    }

    return _singleton;
  }

  AppAPI._private();

  UserAPI userAPI = UserAPI();
}
