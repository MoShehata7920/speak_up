import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import 'package:speak_up/core/widgets/app_text.dart';
import 'package:speak_up/core/resources/assets_manager.dart';
import 'package:speak_up/core/constants.dart';
import 'package:speak_up/core/resources/icons_manager.dart';
import 'package:speak_up/core/resources/routes_manager.dart';
import 'package:speak_up/core/resources/strings_manager.dart';
import 'package:speak_up/core/resources/utils.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_state.dart';
import 'package:speak_up/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:speak_up/features/settings/presentation/cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppStrings.settings.tr(),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.logoutSuccess.tr()),
                duration: const Duration(seconds: 1),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.logInRoute,
              (route) => false,
            );
          } else if (state is SignOutError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileSection(size, context, state),
                SizedBox(height: size.height * 0.02),
                AppText(
                  text: AppStrings.preferences.tr(),
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.01),
                _buildLanguageTile(context, state),
                _buildThemeTile(context, state),
                _buildNotificationsTile(context, state),
                const Divider(height: 40),
                _buildAboutTile(context),
                _buildLogoutTile(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileSection(
    Size size,
    BuildContext context,
    SettingsState state,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.editProfileRoute);
      },
      child: Row(
        children: [
          Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image:
                    state.profileImage != null && state.profileImage!.isNotEmpty
                        ? MemoryImage(base64Decode(state.profileImage!))
                        : AssetImage(AppImages.profilePlaceholder)
                            as ImageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: state.fullName ?? AppStrings.loading.tr(),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                text:
                    supabase.Supabase.instance.client.auth.currentUser?.email ??
                    AppStrings.loading.tr(),
                fontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(AppIcons.language),
      title: AppText(text: AppStrings.language.tr()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(text: state.currentLocale.languageCode.toUpperCase()),
          const Icon(AppIcons.forwardArrow, size: 16),
        ],
      ),
      onTap: () => _showLanguageDialog(context, state),
    );
  }

  void _showLanguageDialog(BuildContext context, SettingsState state) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: AppText(text: AppStrings.selectLanguage.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Locale>(
                  title: const Text(AppConstants.english),
                  value: const Locale('en'),
                  groupValue: state.currentLocale,
                  onChanged: (locale) async {
                    context.read<SettingsCubit>().changeLanguage(locale!);
                    await context.setLocale(locale);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<Locale>(
                  title: const Text(AppConstants.arabic),
                  value: const Locale('ar'),
                  groupValue: state.currentLocale,
                  onChanged: (locale) async {
                    context.read<SettingsCubit>().changeLanguage(locale!);
                    await context.setLocale(locale);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildThemeTile(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(AppIcons.darkMode),
      title: AppText(text: AppStrings.darkMode.tr()),
      trailing: Switch(
        value: state.isDarkMode,
        onChanged: (value) {
          context.read<SettingsCubit>().toggleTheme(value);
        },
      ),
    );
  }

  Widget _buildNotificationsTile(BuildContext context, SettingsState state) {
    return ListTile(
      leading: const Icon(AppIcons.notifications),
      title: AppText(text: AppStrings.notifications.tr()),
      trailing: Switch(
        value: state.notificationsEnabled,
        onChanged: (value) {
          context.read<SettingsCubit>().toggleNotifications(value);
        },
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(AppIcons.about),
      title: AppText(text: AppStrings.aboutApp.tr()),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: AppConstants.applicationName,
          applicationVersion: AppConstants.applicationVersion,
          applicationLegalese: AppConstants.applicationLegalese,
        );
      },
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(AppIcons.logout, color: Colors.red),
      title: AppText(text: AppStrings.logout.tr(), color: Colors.red),
      onTap: () {
        context.read<AuthCubit>().signOut();
      },
    );
  }
}
