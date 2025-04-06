import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final Locale currentLocale;
  final String? fullName;
  final String? profileImage;

  const SettingsState({
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.currentLocale,
    this.fullName,
    this.profileImage,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    Locale? currentLocale,
    String? fullName,
    String? profileImage,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      currentLocale: currentLocale ?? this.currentLocale,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [
    isDarkMode,
    notificationsEnabled,
    currentLocale,
    fullName,
    profileImage,
  ];
}
