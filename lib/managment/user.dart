import 'package:igroove_ui/api/igroove_api.dart';
import 'package:igroove_ui/db/database.dart';
import 'package:igroove_ui/models/test_api.dart';
import 'package:igroove_ui/models/user_db.dart';

class UserMeneger {
  List<TestApiModel> testList = List();

  User user;

  Future<String> getUserAPI() async {
    var result = await AppAPI().userAPI.getUser();
    testList = result.response;
    return result.error;
  }

  Future<String> signUp(
      {String firstName,
      String lastName,
      String email,
      String id,
      String password}) async {
    var result = await DatabaseProvider.db.insert({
      DatabaseProvider.FIRST_NAME: firstName,
      DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.LAST_NAME: lastName,
      DatabaseProvider.EMAIL: email,
      DatabaseProvider.PASSWORD: password,
    });

    if (result == 0) {
      return "Something went wrong";
    }

    return null;
  }

  Future<bool> checkDbUserExistingByEmail(String email) async {
    var result = await DatabaseProvider.db.checkUserExistingByEmail(email);

    return result.response;
  }

  Future<String> login(String email, String password) async {
    var result = await DatabaseProvider.db.login(email, password);

    if (result.error == null) {
      print("User is not null");
      user = result.response;
    }

    return result.error;
  }

  Future<String> updateDbUser({String field, dynamic newWalue}) async {
    var result =
        await DatabaseProvider.db.update(field: field, newWalue: newWalue);

    if (result.error == null) {
      print("User is not null");
      user = result.response;
    }

    return result.error;
  }

  Future<String> changeDbUserEmail({String newEmail, String password}) async {
    var result = await DatabaseProvider.db
        .changeEmail(newEmail: newEmail, password: password);

    if (result.error == null) {
      print("User is not null");
      user = result.response;
    }

    return result.error;
  }

  Future<String> changeDbUserPassword(
      {String newPassword, String password}) async {
    var result = await DatabaseProvider.db
        .changePassword(newPassword: newPassword, password: password);

    if (result.error == null) {
      print("User is not null");
      user = result.response;
    }

    return result.error;
  }
}
