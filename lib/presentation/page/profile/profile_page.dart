import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/core/widget/back_page_button.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/edit_profile_page.dart';
import 'package:smart_courier_assistant/presentation/page/profile/widget/logout_modal_sheet.dart';
import 'package:smart_courier_assistant/presentation/page/profile/widget/section_list_tile.dart';
import 'package:smart_courier_assistant/presentation/page/profile/widget/user_avatar_section.dart';
import 'package:smart_courier_assistant/presentation/page/profile/widget/user_full_name_section.dart';
import 'package:smart_courier_assistant/presentation/page/routes_history/routes_history_page.dart';
import 'package:smart_courier_assistant/presentation/page/settings/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackPageButton(),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            const UserAvatarSection(),
            const SizedBox(height: 10),
            const UserFullNameSection(),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  SectionListTile(
                    leadingEmoji: '👤',
                    title: 'Your profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                  SectionListTile(
                    leadingEmoji: '🗺️',
                    title: 'My routes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RoutesHistoryPage(),
                        ),
                      );
                    },
                  ),
                  SectionListTile(
                    leadingEmoji: '📦',
                    title: 'My orders',
                    onTap: () {},
                  ),
                  SectionListTile(
                    leadingEmoji: '⚙️',
                    title: S.of(context).settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),
                  SectionListTile(
                    leadingEmoji: '🚪',
                    title: 'Logout',
                    isLogOut: true,
                    onTap: () => UiHelper.showModalSheet(
                      context,
                      const LogoutModalSheet(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
