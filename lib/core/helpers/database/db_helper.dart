import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  DbHelper() {
    initWinDB();
  }

  Future<Database> initWinDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(onCreate: _onCreate, version: 1),
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;

    await db.execute("""

 """);
  }
}
