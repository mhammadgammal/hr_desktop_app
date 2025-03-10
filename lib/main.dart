import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/bloc_observer.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/core/helpers/cache/cache_keys.dart';
import 'package:hr/core/helpers/cache/shared_preferences/cache_helper.dart';
import 'package:hr/infinity_hr_app.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = InfinityHrObserver();
  await init();

  var isLogged = sl<CacheHelper>().getBool(key: CacheKeys.isLogged);
  if (Platform.isWindows) {
    setWindowMinSize(const Size(1200, 1000)); // Minimum width and height
  }

  try {
    runApp(InfinityHrApp(isLogged));
  } catch (e, s) {
    File('error_log.txt').writeAsStringSync('$e\n$s');
  }
}
