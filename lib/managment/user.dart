import 'package:http/http.dart' as http;
import 'package:igroove_ui/api/igroove_api.dart';
import 'package:igroove_ui/db/database.dart';
import 'package:igroove_ui/models/test_api.dart';
import 'package:igroove_ui/models/user_db.dart';

class UserMeneger {
  List<TestApiModel> testList = List();

  User user;

  // bool dataLoaded = false;

  Future<String> getUserAPI() async {
    var result = await AppAPI().userAPI.getUser();
    testList = result.response;
    return result.error;
  }

  Future<String> login(String email, String password) async {
    var result = await DatabaseProvider.db.login(email, password);

    user = result.response;

    return result.error;
  }

  Future<String> updateDbUser({String field, dynamic newWalue}) async {
    var result =
        await DatabaseProvider.db.update(field: field, newWalue: newWalue);

    user = result.response;

    return result.error;
  }

  Future<String> changeDbUserEmail({String newEmail, String password}) async {
    var result = await DatabaseProvider.db
        .changeEmail(newEmail: newEmail, password: password);

    if (result.error == null) {
      user = result.response;
    }

    return result.error;
  }
}
