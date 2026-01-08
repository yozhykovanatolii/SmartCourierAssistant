class SettingsState {
  final bool isDarkMode;
  final String languageCode;

  SettingsState({
    required this.isDarkMode,
    required this.languageCode,
  });

  factory SettingsState.initial() {
    return SettingsState(
      isDarkMode: false,
      languageCode: 'en',
    );
  }

  SettingsState copyWith({
    bool? isDarkMode,
    String? languageCode,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
