import 'package:smart_courier_assistant/data/datasource/local/settings_shared_preference.dart';

class SettingsRepository {
  final SettingsSharedPreference _settingsSharedPreference =
      SettingsSharedPreference();

  SettingsRepository();

  Future<bool> loadThemeMode() async =>
      _settingsSharedPreference.loadThemeMode();

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _settingsSharedPreference.saveThemeMode(isDarkMode);
  }

  Future<String> loadLanguageCode() async {
    return await _settingsSharedPreference.loadLanguageCode();
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await _settingsSharedPreference.saveLanguageCode(languageCode);
  }
}
