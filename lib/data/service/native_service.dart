import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.example.app/native');

  static Future<void> openDialer(String phoneNumber) async {
    final number = phoneNumber.isEmpty ? null : phoneNumber;
    try {
      await platform.invokeMethod('openDialer', {'phoneNumber': number});
    } on PlatformException {
      rethrow;
    }
  }

  static Future<void> openWhatsAppChat(String phoneNumber) async {
    final number = phoneNumber.isEmpty ? null : phoneNumber;
    try {
      await platform.invokeMethod('openWhatsAppChat', {
        'phoneNumber': number,
      });
    } on PlatformException {
      rethrow;
    }
  }
}
