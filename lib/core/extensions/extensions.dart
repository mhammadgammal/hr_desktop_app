import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hr/core/utils/localization/app_localization.dart';

extension ColorHex on Color {
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension StringLog on String {
  void logg() {
    log(this);
  }
}

extension Transalation on String {
  String tr(BuildContext context) {
    try {
      return AppLocalizations.of(context).translate(this);
    } catch (_) {
      return this;
    }
  }
}
