import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension LocalizationExtension on BuildContext {
  String i18n(String key) {
    return FlutterI18n.translate(this, key);
  }
}
