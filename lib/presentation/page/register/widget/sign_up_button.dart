import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, FormStatus>(
      selector: (state) => state.formStatus,
      builder: (context, formStatus) {
        final child = formStatus == FormStatus.loading
            ? const CommonProgressIndicator(scale: 0.8)
            : Text(
                S.of(context).signUp,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              );
        return CommonButton(
          width: MediaQuery.of(context).size.width,
          onPressed: () => context.read<RegisterCubit>().signUpUser(),
          child: child,
        );
      },
    );
  }
}
