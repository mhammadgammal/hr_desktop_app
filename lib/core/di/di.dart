import 'package:get_it/get_it.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/core/helpers/database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initDatabase();
  await initCache();
}

Future<void> initDatabase() async {
  final winDb = await DbHelper.initWinDB();
  //<Database>(() => );
  sl.registerSingleton<Database>(winDb);
}

Future<void> initCache() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<CacheHelper>(() =>
      CacheHelper(
        sl.get(),
      ));
}
