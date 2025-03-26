import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/manager/bottom_nav/bottom_nav_cubit.dart';
import 'package:speak_up/manager/bottom_nav/bottom_nav_state.dart';
import 'package:speak_up/resources/icons_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/screens/ai_chat/ai_chat_screen.dart';
import 'package:speak_up/screens/conversation/conversation_screen.dart';
import 'package:speak_up/screens/home/home_screen.dart';
import 'package:speak_up/screens/settings/settings_screen.dart';

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
      _buildNavBarItem(AppIcons.home, AppStrings.home),
      _buildNavBarItem(AppIcons.conversations, AppStrings.conversations),
      _buildNavBarItem(AppIcons.aiChat, AppStrings.aiChat),
      _buildNavBarItem(AppIcons.settings, AppStrings.settings),
    ];
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon, size: 30), label: label);
  }
}
