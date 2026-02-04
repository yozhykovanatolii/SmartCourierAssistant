import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.example.app/native');

  static Future<void> openExtrenal(String action, String phoneNumber) async {
    final number = phoneNumber.isEmpty ? null : phoneNumber;
    try {
      await platform.invokeMethod(action, {'phoneNumber': number});
    } on PlatformException {
      rethrow;
    }
  }
}
