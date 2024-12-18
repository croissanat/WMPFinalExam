import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;
  static const String DB_NAME = 'app_database.db';
  static const String TABLE_USER = 'user_table';
  static const String TABLE_SUBJECT = 'subject_table';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE_USER (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $TABLE_SUBJECT (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        subject_name TEXT,
        credit INTEGER,
        FOREIGN KEY(user_id) REFERENCES $TABLE_USER(id)
      )
    ''');
  }

  Future<void> addUser(String name, String email, String password) async {
    final db = await database;
    await db.insert(TABLE_USER, {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    var result = await db.query(TABLE_USER, where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> addSubject(int userId, String subjectName, int credit) async {
    final db = await database;
    await db.insert(TABLE_SUBJECT, {
      'user_id': userId,
      'subject_name': subjectName,
      'credit': credit,
    });
  }

  Future<List<Map<String, dynamic>>> getSubjects(int userId) async {
    final db = await database;
    return await db.query(TABLE_SUBJECT, where: 'user_id = ?', whereArgs: [userId]);
  }
}
