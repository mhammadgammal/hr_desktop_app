import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/infinity_hr_app.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  if (Platform.isWindows) {
    setWindowMinSize(const Size(1200, 800)); // Minimum width and height
  }
  runApp(const InfinityHrApp());
}
