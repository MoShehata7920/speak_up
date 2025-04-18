import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:speak_up/core/data/repo.dart';
import 'package:speak_up/core/resources/routes_manager.dart';
import 'package:speak_up/core/resources/strings_manager.dart';

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
                  AppStrings.welcomeTpSpeakUp.tr(),
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
    final prefs = await SharedPreferences.getInstance();
    final repository = Repository();
    bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    bool isAuthenticated = await repository.getAuthenticationStatus();

    final user = Supabase.instance.client.auth.currentUser;

    String nextRoute;

    if (onboardingSeen) {
      if (user != null && isAuthenticated) {
        nextRoute = Routes.navBarRoute;
      } else {
        nextRoute = Routes.logInRoute;
      }
    } else {
      nextRoute = Routes.onBoardingRoute;
    }

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, nextRoute);
    });
  }
}
