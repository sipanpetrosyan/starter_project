import 'package:igroove_ui/models/user_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_NAME = "users";
  static const String COLUMN_ID = "id";
  static const String FIRST_NAME = "first_name";
  static const String LAST_NAME = "last_name";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print('database getter called');
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    print('$dbPath/user.db');
    return await openDatabase(
      '$dbPath/user.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating table");
        await database.execute(
          "CREATE TABLE $TABLE_NAME ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$FIRST_NAME TEXT,"
          "$LAST_NAME TEXT,"
          "$EMAIL TEXT,"
          "$PASSWORD TEXT,"
          ")",
        );
      },
    );
  }

  Future<List<User>> getUser() async {
    final db = await database;
    var users = await db.query(TABLE_NAME,
        columns: [COLUMN_ID, FIRST_NAME, LAST_NAME, EMAIL, PASSWORD]);

    List<User> userList = List<User>();
    users.forEach((element) {
      User user = User.fromMap(element);
      userList.add(user);
    });

    return userList;
  }
}
