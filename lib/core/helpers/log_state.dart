import 'package:flutter/foundation.dart';

class Console {
  static void log(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
