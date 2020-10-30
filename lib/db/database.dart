import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/models/basic_api_response.dart';
import 'package:igroove_ui/models/user_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_USER = "users";
  static const String COLUMN_ID = "id";
  static const String FIRST_NAME = "first_name";
  static const String LAST_NAME = "last_name";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String IMAGE = "image_url";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    print('database getter called');
    if (_database != null) {
      print("database is not null");
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  //create new DB
  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    print('$dbPath/user.db');
    return await openDatabase(
      '$dbPath/user.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating table");
        await database.execute(
          '''CREATE TABLE $TABLE_USER (
          $COLUMN_ID TEXT PRIMARY KEY,
          $FIRST_NAME TEXT,
          $LAST_NAME TEXT,
          $EMAIL TEXT,
          $PASSWORD TEXT,
          $IMAGE TEXT
          )''',
        );
      },
    );
  }

  // all user full info
  Future<List<User>> getUsers() async {
    final db = await database;
    var users = await db.query(TABLE_USER,
        columns: [COLUMN_ID, FIRST_NAME, LAST_NAME, EMAIL, PASSWORD]);

    List<User> userList = List<User>();
    users.forEach((element) {
      User user = User.fromMap(element);
      userList.add(user);
    });

    print(userList.length);
    return userList;
  }

  //is there a user with such an email address
  Future<BasicResponse<bool>> checkUserExistingByEmail(String email) async {
    final db = await database;
    var userMap;
    String error;
    bool checkResult = false;

    try {
      userMap = await db.rawQuery('''
      SELECT *
      FROM users
      WHERE ($EMAIL = '$email' )
    ''');
    } catch (e) {
      error = e.toString();
    }

    if (userMap != null && userMap.length != 0) {
      checkResult = true;
    }
    return BasicResponse(error: error, response: checkResult);
  }

  // signIn user
  Future<BasicResponse<User>> login(String email, String password) async {
    final db = await database;
    var userMap;
    String error;

    try {
      userMap = await db.rawQuery('''
      SELECT *
      FROM users
      WHERE ($EMAIL = '$email' AND $PASSWORD = '$password')
    ''');
    } catch (e) {
      error = e.toString();
    }

    User user;
    if (userMap != null && userMap.length != 0) {
      user = User.fromMap(userMap.first);
    } else {
      error = "User not found.";
    }

    return BasicResponse(error: error, response: user);
  }

  // select user info by id
  Future<BasicResponse<User>> getUser(String uid) async {
    final db = await database;
    var userMap;
    String error;

    try {
      userMap = await db.rawQuery('''
      SELECT *
      FROM users
      WHERE ($COLUMN_ID = '$uid' )
    ''');
    } catch (e) {
      error = e.toString();
    }

    User user;
    if (userMap != null && userMap.length != 0) {
      user = User.fromMap(userMap.first);
    }

    return BasicResponse(error: error, response: user);
  }

  // signUp user
  Future<int> insert(Map user) async {
    final db = await database;
    return await db.insert(TABLE_USER, user.cast<String, dynamic>());
  }

  // update user info by id
  Future<BasicResponse<User>> update({String field, dynamic newWalue}) async {
    final db = await database;
    String userId = AppManager().userMeneger.user.id;

    int result = await db.rawUpdate('''
    UPDATE $TABLE_USER 
    SET $field = '$newWalue'
    WHERE $COLUMN_ID = '$userId'
    ''');

    if (result == 1) {
      return await this.getUser(userId);
    } else {
      return BasicResponse(error: "Something went wrong", response: null);
    }
  }

  // change email user, update info user by check password valid
  Future<BasicResponse<User>> changeEmail(
      {String newEmail, String password}) async {
    final db = await database;
    String userId = AppManager().userMeneger.user.id;

    int result = await db.rawUpdate('''
    UPDATE $TABLE_USER 
    SET $EMAIL = '$newEmail'
    WHERE $EMAIL = '${AppManager().userMeneger.user.email}' AND $PASSWORD = '$password'
    ''');

    if (result == 1) {
      return await this.getUser(userId);
    } else {
      return BasicResponse(error: "Password is wrong", response: null);
    }
  }

  //change password user, update info user by check password valid and oldPassword == newPassword
  Future<BasicResponse<User>> changePassword(
      {String newPassword, String password}) async {
    final db = await database;

    String userId = AppManager().userMeneger.user.id;

    int result = await db.rawUpdate('''
    UPDATE $TABLE_USER 
    SET $PASSWORD = '$newPassword'
    WHERE $COLUMN_ID = '${AppManager().userMeneger.user.id}' AND $PASSWORD = '$password'
    ''');

    if (result == 1) {
      return await this.getUser(userId);
    } else {
      return BasicResponse(error: "Password is wrong", response: null);
    }
  }
}
