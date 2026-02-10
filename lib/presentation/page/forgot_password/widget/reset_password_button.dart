import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final formStatus = context.select(
      (ForgotPasswordCubit bloc) => bloc.state.formStatus,
    );
    final child = formStatus == FormStatus.loading
        ? const CommonProgressIndicator(scale: 0.8)
        : Text(
            S.of(context).resetPassword,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          );
    return CommonButton(
      width: MediaQuery.of(context).size.width,
      onPressed: () => context.read<ForgotPasswordCubit>().sendEmailLetter(),
      child: child,
    );
  }
}
