import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';

class ProfileFullNameTextField extends StatelessWidget {
  final TextEditingController? controller;

  const ProfileFullNameTextField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final fullNameError = context.select(
      (EditProfileCubit bloc) => bloc.state.fullNameError,
    );
    return CommonTextField(
      controller: controller,
      onChanged: (fullName) {
        context.read<EditProfileCubit>().editUserFullName(fullName);
      },
      hintText: 'Enter your full name',
      errorText: fullNameError,
    );
  }
}
