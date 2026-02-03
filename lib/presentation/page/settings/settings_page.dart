import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
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
      body: ListView(
        children: [
          SettingListTile(
            text: S.of(context).darkMode,
            trailing: const ThemeSwitch(),
          ),
          SettingListTile(
            text: S.of(context).language,
            trailing: const LanguageButton(),
          ),
        ],
      ),
    );
  }
}
