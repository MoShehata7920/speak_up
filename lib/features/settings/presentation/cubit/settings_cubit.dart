import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:speak_up/core/repo.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Repository repository;
  final supabase.SupabaseClient supabaseClient;

  SettingsCubit(this.repository, this.supabaseClient)
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

    final user = supabaseClient.auth.currentUser;
    String? fullName;
    String? profileImage;
    if (user != null) {
      final response =
          await supabaseClient
              .from('users')
              .select('full_name, profile_image')
              .eq('id', user.id)
              .single();
      fullName = response['full_name'] as String?;
      profileImage = response['profile_image'] as String?;
    }

    emit(
      SettingsState(
        isDarkMode: isDark,
        notificationsEnabled: notifications,
        currentLocale: locale,
        fullName: fullName,
        profileImage: profileImage,
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

  Future<void> updateProfile({String? fullName, String? profileImage}) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return;

    final updates = <String, dynamic>{};
    if (fullName != null && fullName != state.fullName) {
      updates['full_name'] = fullName;
    }
    if (profileImage != null && profileImage != state.profileImage) {
      updates['profile_image'] = profileImage;
    }

    if (updates.isNotEmpty) {
      await supabaseClient.from('users').update(updates).eq('id', user.id);
      emit(
        state.copyWith(
          fullName: fullName ?? state.fullName,
          profileImage: profileImage ?? state.profileImage,
        ),
      );
    }
  }
}
