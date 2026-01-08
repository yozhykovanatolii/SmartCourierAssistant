import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';

class LanguageListTile extends StatelessWidget {
  final String countryLanguage;
  final String countryCode;
  final String languageCode;

  const LanguageListTile({
    super.key,
    required this.countryCode,
    required this.countryLanguage,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select(
      (SettingsCubit cubit) => cubit.state.languageCode == languageCode,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: isSelected ? 2 : 0.8,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
      child: ListTile(
        onTap: () {
          context.read<SettingsCubit>().changeLanguageCode(languageCode);
        },
        leading: Text(
          countryCode,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        title: Text(
          countryLanguage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: isSelected
            ? const Icon(color: Color(0xFF009688), Icons.check_circle)
            : null,
      ),
    );
  }
}
