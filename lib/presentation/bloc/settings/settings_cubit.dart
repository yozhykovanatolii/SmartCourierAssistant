import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/data/repository/settings_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository = SettingsRepository();

  SettingsCubit() : super(SettingsState.initial());

  Future<void> fetchSettings() async {
    final isDarkMode = await _settingsRepository.loadThemeMode();
    final languageCode = await _settingsRepository.loadLanguageCode();
    emit(
      state.copyWith(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ),
    );
  }

  Future<void> changeThemeMode(bool isDarkMode) async {
    emit(state.copyWith(isDarkMode: isDarkMode));
    await _settingsRepository.saveThemeMode(isDarkMode);
  }

  Future<void> changeLanguageCode(String languageCode) async {
    emit(state.copyWith(languageCode: languageCode));
    await _settingsRepository.saveLanguageCode(languageCode);
  }
}
