import 'package:get_it/get_it.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initDatabase();
  initCache();
}

Future<void> initDatabase() async {
  final winDb = await DbHelper.initWinDB();
  //<Database>(() => );
  sl.registerSingleton<Database>(winDb);
}

void initCache() async {}
