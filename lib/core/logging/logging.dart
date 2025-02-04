import 'dart:developer';
import 'package:flutter/foundation.dart';

///helper logging method, will only log in debug mode
void kLog(String message, {String name = ""}) {
  if (kDebugMode) {
    log(message, name: name);
  }
}
