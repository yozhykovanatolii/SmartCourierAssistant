import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_text_field.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class LoginEmailTextField extends StatelessWidget {
  const LoginEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, String?>(
      selector: (state) => state.emailError,
      builder: (context, emailError) {
        return CommonTextField(
          onChanged: (email) => context.read<LoginCubit>().setLoginEmail(email),
          hintText: S.of(context).enterYourEmail,
          errorText: emailError,
        );
      },
    );
  }
}
