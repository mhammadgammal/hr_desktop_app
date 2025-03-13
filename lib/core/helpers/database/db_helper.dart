import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:hr/core/di/di.dart';
import 'package:hr/core/extensions/extensions.dart';
import 'package:hr/core/helpers/database/table_name.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  DbHelper() {
    initWinDB();
  }

  static Future<Database> initWinDB() async {
    sqfliteFfiInit();
    String? userProfile =
        Platform.isWindows
            ? Platform.environment['USERPROFILE']
            : Platform.isMacOS
            ? Platform.environment['CFFIXED_USER_HOME']
            : '';
    late String documentsPath;
    if (userProfile != null) {
      if (Platform.isWindows) {
        documentsPath = '$userProfile\\Documents';
      } else {
        documentsPath = '$userProfile/Documents';
      }
      log('Documents Directory: $documentsPath');
    } else {
      documentsPath = '';
      log('Could not determine Documents directory.');
    }
    late String dbPath;

    if (Platform.isWindows) {
      dbPath = '$documentsPath\\HR.db';
    } else {
      dbPath = '$documentsPath/HR.db';
    }

    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        onConfigure: (db) async {
          // Enable foreign key constraints in SQLite
          await db.execute("PRAGMA foreign_keys = ON");
        },
        onCreate: _onCreate,
        // onUpgrade: _onUpgrade,
        version: 5,
      ),
    );
  }

  static Future<void> _onCreate(Database database, int version) async {
    final db = database;

    _createUserTable(db);
    _createEmployeeTable(db);
    _createContractTable(db);
    _createVacationTable(db);
  }

  static void _createUserTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS ${TableName.userTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    profile_picture_path TEXT
    );
 """);
  }

  static void _createEmployeeTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS ${TableName.employeeTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    birthdate VARCHAR(255) NOT NULL,
    job VARCHAR(255) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    salary_date VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    working_hours INT NOT NULL,
    working_days VARCHAR(255) NOT NULL,
    identity_type VARCHAR(255) NOT NULL,
    identity_number VARCHAR(255) NOT NULL,
    identity_type_pic_path VARCHAR(255) NOT NULL,
    vacation_count INTEGER NOT NULL
    );
    """);
  }

  static void _createContractTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS ${TableName.contractTable} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    emp_id INT UNIQUE,
    contract_pic_path VARCHAR(255) NOT NULL,
    start_date VARCHAR(255) NOT NULL,
    end_date VARCHAR(255) NOT NULL,
    overtime_yearly Int NOT NULL,
    overtime_monthly Int NOT NULL,
    overtime_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES ${TableName.employeeTable}(id) ON DELETE CASCADE ON UPDATE CASCADE
    );
    """);
  }

  static void _createVacationTable(Database db) async {
    db.execute("""
  CREATE TABLE ${TableName.vacationTable} (
	id	INTEGER NOT NULL,
	emp_id	INTEGER NOT NULL,
	start_date	INTEGER NOT NULL,
	end_date	INTEGER NOT NULL,
	PRIMARY KEY(id AUTOINCREMENT),
	FOREIGN KEY(emp_id) REFERENCES ${TableName.employeeTable}(id) ON DELETE CASCADE ON UPDATE CASCADE
  );
    """);
  }

  static Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    final db = sl<Database>();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps;
  }

  static Future<Map<String, dynamic>> getRecordById(
    int id, {
    required String tableName,
  }) async {
    final db = sl<Database>();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.first;
  }

  static Future<Map<String, dynamic>> getRecordByEmail(
    String email, {
    required String tableName,
  }) async {
    final db = sl<Database>();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.first;
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

  static Future<int> insertData(String table, Map<String, dynamic> data) async {
    try {
      'Inserting data into $table: $data'.logg();
      int insertedId = await sl<Database>().insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return insertedId;
    } catch (e) {
      log('Error inserting data: $e');
      return -1;
    }
  }

  static Future<bool> deleteData(
    String table,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      await sl<Database>().delete(
        table,
        where: '$where = ?',
        whereArgs: whereArgs,
      );
      return true;
    } catch (e) {
      log('Error deleting data: $e');
      return false;
    }
  }

  static Future<bool> updateData(
    String table,
    Map<String, dynamic> data,
    String where,
    List<dynamic> whereArgs,
  ) async {
    try {
      final updateResult = await sl<Database>().update(
        table,
        data,
        where: '$where = ?',
        whereArgs: whereArgs,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      log('DbHelper: updateData: updateResult = $updateResult');
      return true;
    } catch (e) {
      log('Error updating data: $e');
      return false;
    }
  }

  static Future updateRawData(
    String tableName,
    List<String> values,
    List<dynamic> parameters,
  ) async {
    sl<Database>().execute(
      'update $tableName set $values where id = ?${parameters.last}',
      parameters,
    );
    // await sl<Database>().rawUpdate(
    //   "update $tableName SET $values WHERE id = ?",
    //   parameters,
    // );
  }

  static Future<List<T>> getData<T>(
    String tableName,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final List<Map<String, dynamic>> maps = await sl<Database>().query(
        tableName,
      );
      final List<T> dataList = maps.map((map) => fromJson(map)).toList();
      return dataList;
    } catch (e) {
      log('Error retrieving data: $e');
      // return FailureDataResponse('Error retrieving data: $e');
      return [];
    }
  }

  static Future<List<T>> getDataWhere<T>(
    String tableName,
    T Function(Map<String, dynamic>) fromJson, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final List<Map<String, dynamic>> maps = await sl<Database>().query(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
      final List<T> dataList = maps.map((map) => fromJson(map)).toList();
      return dataList;
    } catch (e) {
      log('Error retrieving data: $e');
      // return FailureDataResponse('Error retrieving data: $e');
      return [];
    }
  }

  static Future<void> closeDb(Database db) async {
    await db.close();
  }

  static FutureOr<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await db.execute('''
        ALTER TABLE ${TableName.contractTable} 
        ADD COLUMN contract_pic_path VARCHAR(255) DEFAULT ''
      ''');
  }
}
