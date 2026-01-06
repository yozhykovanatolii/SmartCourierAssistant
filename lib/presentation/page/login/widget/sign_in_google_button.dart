import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormStatus>(
      selector: (state) => state.googleLoginStatus,
      builder: (context, registerStatus) {
        final child = registerStatus == FormStatus.loading
            ? const CommonProgressIndicator(
                scale: 0.8,
                color: Colors.blue,
              )
            : const _SignInGoogleContent();
        return CommonButton(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFF5F5F5),
          onPressed: () => context.read<LoginCubit>().signInWithGoogle(),
          child: child,
        );
      },
    );
  }
}

class _SignInGoogleContent extends StatelessWidget {
  const _SignInGoogleContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        Image.asset(
          'assets/images/google_icon.png',
          height: 35,
        ),
        const Text(
          'Sign in with Google',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
