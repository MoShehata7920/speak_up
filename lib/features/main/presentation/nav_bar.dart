import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/features/main/presentation/cubit/bottom_nav_cubit.dart';
import 'package:speak_up/features/main/presentation/cubit/bottom_nav_state.dart';
import 'package:speak_up/core/icons_manager.dart';
import 'package:speak_up/core/strings_manager.dart';
import 'package:speak_up/features/ai_chat/presentation/ai_chat_screen.dart';
import 'package:speak_up/features/conversation/presentation/conversation_screen.dart';
import 'package:speak_up/features/home/presentation/home_screen.dart';
import 'package:speak_up/features/settings/presentation/settings_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const ConversationScreen(),
      AiChatScreen(),
      const SettingsScreen(),
    ];

    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            items: _navBarItems(),
            onTap: (index) => context.read<BottomNavCubit>().changeTab(index),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _navBarItems() {
    return [
      _buildNavBarItem(AppIcons.home, AppStrings.home.tr()),
      _buildNavBarItem(AppIcons.conversations, AppStrings.conversations.tr()),
      _buildNavBarItem(AppIcons.aiChat, AppStrings.aiChat.tr()),
      _buildNavBarItem(AppIcons.settings, AppStrings.settings.tr()),
    ];
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon, size: 30), label: label);
  }
}
