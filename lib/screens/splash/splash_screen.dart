import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  AppStrings.welcomeTpSpeakUp,
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
          ),
        ),
      ),
    );
  }

  void navigateToMain() async {
    await Future.delayed(const Duration(seconds: 4));

    final prefs = await SharedPreferences.getInstance();
    bool isOnboardingSeen = prefs.getBool('isOnboardingSeen') ?? false;

    if (!mounted) return;
    if (isOnboardingSeen) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    }
  }
}
