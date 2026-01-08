import 'package:shared_preferences/shared_preferences.dart';

class SettingsSharedPreference {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<bool> loadThemeMode() async {
    final isDarkMode =
        (await _sharedPreferences).getBool('isDarkMode') ?? false;
    return isDarkMode;
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    (await _sharedPreferences).setBool('isDarkMode', isDarkMode);
  }

  Future<String> loadLanguageCode() async {
    final languageCode =
        (await _sharedPreferences).getString('languageCode') ?? 'en';
    return languageCode;
  }

  Future<void> saveLanguageCode(String languageCode) async {
    (await _sharedPreferences).setString('languageCode', languageCode);
  }
}
