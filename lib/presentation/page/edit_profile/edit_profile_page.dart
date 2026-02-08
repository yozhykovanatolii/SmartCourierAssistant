import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_courier_assistant/core/navigation/app_routes.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_event.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_state.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/widget/edit_profile_button.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/widget/profile_avatar_section.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/widget/profile_full_name_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/widget/profile_phone_number_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = context.read<AppBloc>().state;
      if (appState is UserAuthenticatedState) {
        context.read<EditProfileCubit>().fetchUserProfile(appState.user);
        _fullNameController.text = appState.user.fullName;
        _phoneNumberController.text = appState.user.phoneNumber;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editProfile,
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state is UserAuthenticatedState) {
                context.read<EditProfileCubit>().fetchUserProfile(state.user);
                _fullNameController.text = state.user.fullName;
                _phoneNumberController.text = state.user.phoneNumber;
              }
              if (state is UserUnauthenticatedState) {
                UiHelper.showSnackBar(
                  context: context,
                  message: state.errorMessage,
                  isErrorSnackBar: true,
                );
                context.go(AppRoutes.loginPage);
              }
            },
          ),
          BlocListener<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state.formStatus == FormStatus.success) {
                UiHelper.showSnackBar(
                  context: context,
                  message: S.of(context).successUpdatingProfile,
                );
                context.read<AppBloc>().add(AppUserSubscriptionRequested());
              }
              if (state.formStatus == FormStatus.failure) {
                UiHelper.showSnackBar(
                  context: context,
                  message: state.errorMessage,
                  isErrorSnackBar: true,
                );
              }
            },
          ),
        ],
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileAvatarSection(),
              const SizedBox(height: 20),
              Text(
                S.of(context).fullName,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              ProfileFullNameTextField(
                controller: _fullNameController,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).phoneNumber,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              ProfilePhoneNumberTextField(
                controller: _phoneNumberController,
              ),
              const SizedBox(height: 20),
              const EditProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}
