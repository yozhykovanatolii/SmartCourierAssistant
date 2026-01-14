import 'package:flutter/services.dart';

class DialerService {
  static const platform = MethodChannel('com.example.app/dialer');

  static Future<void> openDialer(String phoneNumber) async {
    final number = phoneNumber.isEmpty ? null : phoneNumber;
    try {
      await platform.invokeMethod('openDialer', {'phoneNumber': number});
    } on PlatformException {
      rethrow;
    }
  }
}
