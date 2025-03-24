import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speak_up/service/utils.dart';

class OnboardingPage extends StatelessWidget {
  final String animation;
  final String title;
  final String description;

  const OnboardingPage({
    required this.animation,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(animation, height: size.height * 0.35),
        SizedBox(height: size.height * 0.03),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
