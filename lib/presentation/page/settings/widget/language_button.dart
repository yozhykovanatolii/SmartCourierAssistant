import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/languages/languages_page.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.select(
      (SettingsCubit cubit) => cubit.state.languageCode == 'en',
    );
    return GestureDetector(
      onTap: () => UiHelper.showModalSheet(
        context,
        const LanguagesPage(),
      ),
      child: Text(
        isEnglish ? 'English' : 'Українська',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
