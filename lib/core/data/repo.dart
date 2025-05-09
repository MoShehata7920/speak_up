import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static const String themeKey = 'is_dark_mode';
  static const String notificationsKey = 'notifications_enabled';
  static const String languageKey = 'language_code';
  static const String authKey = 'is_authenticated';

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? false;
  }

  Future<void> saveNotifications(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationsKey, isEnabled);
  }

  Future<bool> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(notificationsKey) ?? true;
  }

  Future<void> saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, locale.languageCode);
  }

  Future<Locale> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(languageKey) ?? 'en';
    return Locale(code);
  }

  Future<void> saveAuthenticationStatus(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(authKey, isAuthenticated);
  }

  Future<bool> getAuthenticationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(authKey) ?? false;
  }
}
