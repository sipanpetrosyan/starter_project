import 'package:igroove_ui/models/user_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_USER = "users";
  static const String COLUMN_ID = "id";
  static const String FIRST_NAME = "first_name";
  static const String LAST_NAME = "last_name";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";

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
          $PASSWORD TEXT
          )''',
        );
      },
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    var users = await db.query(TABLE_USER,
        columns: [COLUMN_ID, FIRST_NAME, LAST_NAME, EMAIL, PASSWORD]);
    // ,
    // whereArgs: ["sipan"],
    // where: '$FIRST_NAME = ?'

    List<User> userList = List<User>();
    users.forEach((element) {
      User user = User.fromMap(element);
      userList.add(user);
    });

    print(userList.length);
    return userList;
  }

  Future<User> getUser(String email) async {
    final db = await database;
    var userMap = await db.query(TABLE_USER,
        columns: [COLUMN_ID, FIRST_NAME, LAST_NAME, EMAIL, PASSWORD],
        whereArgs: [email],
        where: '$EMAIL = ?');

    User user = User.fromMap(userMap.first);

    return user;
  }

  Future<User> insert(User user) async {
    final db = await database;
    await db.insert(TABLE_USER, user.toMap());
    return user;
  }
}
