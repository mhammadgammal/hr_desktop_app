import 'package:flutter/material.dart';
import 'package:hr/core/di/di.dart';
import 'package:hr/infinity_hr_app.dart';

void main() async {
  await init();
  runApp(const InfinityHrApp());
}
