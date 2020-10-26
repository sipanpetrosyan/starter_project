import 'package:igroove_ui/db/database.dart';

class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String password;

  User({this.first_name, this.last_name, this.email, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.FIRST_NAME: first_name,
      DatabaseProvider.LAST_NAME: last_name,
      DatabaseProvider.EMAIL: email,
      DatabaseProvider.PASSWORD: password
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    first_name = map[DatabaseProvider.FIRST_NAME];
    last_name = map[DatabaseProvider.LAST_NAME];
    email = map[DatabaseProvider.EMAIL];
    password = map[DatabaseProvider.PASSWORD];
  }
}
