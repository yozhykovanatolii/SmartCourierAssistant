import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_courier_assistant/core/navigation/app_routes.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/forgot_password_email_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/reset_password_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            UiHelper.showSnackBar(
              context: context,
              message: S
                  .of(context)
                  .ifAnAccountWithThisEmailExistsYouWillReceive,
            );
            context.go(AppRoutes.loginPage);
          }
          if (state.formStatus == FormStatus.failure) {
            UiHelper.showSnackBar(
              context: context,
              message: state.errorMessage,
              isErrorSnackBar: true,
            );
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).forgotPassword,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).enterYourEmailAddressAndWeWillSendYouA,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 50),
                const ForgotPasswordEmailTextField(),
                const SizedBox(height: 30),
                const ResetPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
