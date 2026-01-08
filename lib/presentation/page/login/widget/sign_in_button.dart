import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormStatus>(
      selector: (state) => state.formStatus,
      builder: (context, registerStatus) {
        final child = registerStatus == FormStatus.loading
            ? const CommonProgressIndicator(scale: 0.8)
            : Text(
                S.of(context).signIn,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              );
        return CommonButton(
          width: MediaQuery.of(context).size.width,
          onPressed: () => context.read<LoginCubit>().signInUser(),
          child: child,
        );
      },
    );
  }
}
