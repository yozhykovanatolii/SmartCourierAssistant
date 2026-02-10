import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/page/languages/widget/language_list_tile.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.52,
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
              S.of(context).languages,
              style: TextStyle(
                fontSize: MediaQuery.textScalerOf(context).scale(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              S.of(context).selectTheLanguageThatIsMostConvenientForYouTo,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: MediaQuery.textScalerOf(context).scale(17),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Column(
              spacing: 20,
              children: [
                LanguageListTile(
                  countryCode: '🇺🇦',
                  countryLanguage: 'Українська',
                  languageCode: 'uk',
                ),
                LanguageListTile(
                  countryCode: '🇬🇧',
                  countryLanguage: 'English',
                  languageCode: 'en',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
