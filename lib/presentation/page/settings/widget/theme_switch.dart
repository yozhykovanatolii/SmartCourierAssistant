import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (SettingsCubit cubit) => cubit.state.isDarkMode,
    );
    return Switch(
      value: isDarkMode,
      activeTrackColor: Colors.green,
      activeThumbColor: Colors.white,
      onChanged: (isDarkMode) {
        context.read<SettingsCubit>().changeThemeMode(isDarkMode);
      },
    );
  }
}
