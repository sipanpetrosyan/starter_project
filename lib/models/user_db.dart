import 'package:igroove_ui/db/database.dart';

class User {
   String id;
   String firstName;
   String lastName;
   String email;
   String password;

  User( {this.id,this.firstName, this.lastName, this.email, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.FIRST_NAME: firstName,
      DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.LAST_NAME: lastName,
      DatabaseProvider.EMAIL: email,
      DatabaseProvider.PASSWORD: password
    };
   

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    this.firstName = map[DatabaseProvider.FIRST_NAME];
    lastName = map[DatabaseProvider.LAST_NAME];
    email = map[DatabaseProvider.EMAIL];
    password = map[DatabaseProvider.PASSWORD];
  }
}
