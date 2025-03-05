import 'dart:io';

import 'package:hr/core/di/di.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:hr/features/authentication/data/model/user_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  DbHelper() {
    initWinDB();
  }

  static Future<Database> initWinDB() async {
    sqfliteFfiInit();
    String? userProfile = Platform.environment['USERPROFILE'];
    late String documentsPath;
    if (userProfile != null) {
      documentsPath = '$userProfile\\Documents';
      print('Documents Directory: $documentsPath');
    } else {
      documentsPath = '';
      print('Could not determine Documents directory.');
    }
    String dbPath = '$documentsPath\\hr.db';
    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(onCreate: _onCreate, version: 1),
    );
  }

  static Future<void> _onCreate(Database database, int version) async {
    final db = database;

    await db.execute("""
    CREATE TABLE ${TableName.userTable} (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    profile_picture_path TEXT
    );
 """);
  }

  static Future<void> insertUser(UserModel user) async {
    final db = sl<Database>();
    int result = await db.rawInsert(
      'INSERT OR REPLACE INTO ${TableName.userTable} (id, name, email, password, profile_picture_path) VALUES (?, ?, ?, ?, ?)',
      [user.id, user.name, user.email, user.password, user.profilePicturePath],
    );

    'User inserted: $result'.logg();
  }

  static Future<UserModel?> getUser(String email) async {
    final db = sl<Database>();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM ${TableName.userTable} WHERE email = ?',
      [email],
    );
    return maps.isEmpty ? null : UserModel.fromJson(maps.first);
  }

  static Future<bool> deleteUser(String email) async {
    final db = sl<Database>();
    int result = await db.delete(
      TableName.userTable,
      where: 'email = ?',
      whereArgs: [email],
    );

    return result > 0;
  }

  static Future<void> closeDb(Database db) async {
    await db.close();
  }
}
