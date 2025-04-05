import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/core/repo.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Repository repository;

  SettingsCubit(this.repository)
    : super(
        const SettingsState(
          isDarkMode: false,
          notificationsEnabled: true,
          currentLocale: Locale('en'),
        ),
      ) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final isDark = await repository.getTheme();
    final notifications = await repository.getNotifications();
    final locale = await repository.getLanguage();
    emit(
      SettingsState(
        isDarkMode: isDark,
        notificationsEnabled: notifications,
        currentLocale: locale,
      ),
    );
  }

  Future<void> toggleTheme(bool isDark) async {
    await repository.saveTheme(isDark);
    emit(state.copyWith(isDarkMode: isDark));
  }

  Future<void> toggleNotifications(bool isEnabled) async {
    await repository.saveNotifications(isEnabled);
    emit(state.copyWith(notificationsEnabled: isEnabled));
  }

  Future<void> changeLanguage(Locale locale) async {
    await repository.saveLanguage(locale);
    emit(state.copyWith(currentLocale: locale));
  }
}
