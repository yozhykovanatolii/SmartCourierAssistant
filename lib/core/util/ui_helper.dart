import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/snack_bar_body.dart';

class UiHelper {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isErrorSnackBar = false,
  }) {
    var snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: SnackBarBody(
        backgroundColor: isErrorSnackBar ? 0xFFFFEEEF : 0xFFD4FFFE,
        color: isErrorSnackBar ? 0xFFE77282 : 0xFF009688,
        message: message,
        iconData: isErrorSnackBar ? Icons.error : Icons.check_circle,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showModalSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (_) => widget,
    );
  }
}
