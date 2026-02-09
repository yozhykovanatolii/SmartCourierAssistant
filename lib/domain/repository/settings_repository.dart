abstract interface class SettingsRepository {
  Future<bool> loadThemeMode();
  Future<void> saveThemeMode(bool isDarkMode);
  Future<String> loadLanguageCode();
  Future<void> saveLanguageCode(String languageCode);
}
