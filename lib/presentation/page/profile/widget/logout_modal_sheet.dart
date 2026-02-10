import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/widget/common_button.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';

class LogoutModalSheet extends StatelessWidget {
  const LogoutModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.693,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              S.of(context).logout,
              style: TextStyle(
                fontSize: MediaQuery.textScalerOf(context).scale(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              S.of(context).areYouSureYouWantToLogOut,
              style: TextStyle(
                fontSize: MediaQuery.textScalerOf(context).scale(20),
                fontWeight: FontWeight.w500,
              ),
            ),
            const _LogoutActionButtonsSection(),
          ],
        ),
      ),
    );
  }
}

class _LogoutActionButtonsSection extends StatelessWidget {
  const _LogoutActionButtonsSection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: AlignmentGeometry.bottomCenter,
        child: Row(
          spacing: 20,
          children: [
            Flexible(
              child: _LogoutActionButton(
                text: S.of(context).cancel,
                onPressed: () => Navigator.of(context).pop(),
                isLogOutButton: false,
              ),
            ),
            Flexible(
              child: _LogoutActionButton(
                text: S.of(context).yesLogout,
                onPressed: () {
                  context.read<EditProfileCubit>().logOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutActionButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isLogOutButton;

  const _LogoutActionButton({
    required this.text,
    required this.onPressed,
    this.isLogOutButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: MediaQuery.of(context).size.width / 2,
      onPressed: onPressed,
      color: isLogOutButton ? Colors.red : Colors.grey,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          color: isLogOutButton ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
