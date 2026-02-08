import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/navigation/app_routes.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/language_button.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/setting_list_tile.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/theme_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is UserUnauthenticatedState) {
            UiHelper.showSnackBar(
              context: context,
              message: state.errorMessage,
              isErrorSnackBar: true,
            );
            context.go(AppRoutes.loginPage);
          }
        },
        child: ListView(
          children: [
            SettingListTile(
              leadingIcon: Iconsax.sun_1,
              text: S.of(context).darkMode,
              trailing: const ThemeSwitch(),
            ),
            SettingListTile(
              leadingIcon: Iconsax.language_circle,
              text: S.of(context).language,
              trailing: const LanguageButton(),
            ),
          ],
        ),
      ),
    );
  }
}
