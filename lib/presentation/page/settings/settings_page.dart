import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/language_button.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/setting_list_tile.dart';
import 'package:smart_courier_assistant/presentation/page/settings/widget/theme_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SettingListTile(
            leadingIcon: Iconsax.sun_1,
            text: 'Dark Mode',
            trailing: ThemeSwitch(),
          ),
          const SettingListTile(
            leadingIcon: Iconsax.language_circle,
            text: 'Language',
            trailing: LanguageButton(),
          ),
        ],
      ),
    );
  }
}
