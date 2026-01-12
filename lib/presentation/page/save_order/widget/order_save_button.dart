import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';

class OrderSaveButton extends StatelessWidget {
  const OrderSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: MediaQuery.of(context).size.width,
      onPressed: () {},
      child: Text(
        S.of(context).save,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
