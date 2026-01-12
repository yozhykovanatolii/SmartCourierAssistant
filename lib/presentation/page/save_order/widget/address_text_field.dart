import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      onChanged: (fullName) => print(fullName),
      hintText: 'Enter address of order',
      suffixIcon: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.scan,
          color: Colors.blue,
        ),
      ),
      //errorText: fullNameError,
    );
  }
}
