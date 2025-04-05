import 'package:flutter/material.dart';

class SettingsState {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final Locale currentLocale;

  const SettingsState({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.currentLocale,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    Locale? currentLocale,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }
}
