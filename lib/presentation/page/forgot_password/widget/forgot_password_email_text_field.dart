import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';

class ForgotPasswordEmailTextField extends StatelessWidget {
  const ForgotPasswordEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final emailErrorMessage = context.select(
      (ForgotPasswordCubit bloc) => bloc.state.emailErrorMessage,
    );
    return CommonTextField(
      onChanged: (email) =>
          context.read<ForgotPasswordCubit>().changeUserEmail(email),
      hintText: S.of(context).enterYourEmail,
      errorText: emailErrorMessage,
    );
  }
}
