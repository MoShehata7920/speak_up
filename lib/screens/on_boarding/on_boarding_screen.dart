import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/screens/on_boarding/on_boarding_page.dart';
import 'package:speak_up/service/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 2);
                },
                children: const [
                  OnboardingPage(
                    animation: AppJson.onBoarding1,
                    title: AppStrings.learnLanguagesEasy,
                    description: AppStrings.practiceConversations,
                  ),
                  OnboardingPage(
                    animation: AppJson.onBoarding2,
                    title: AppStrings.aiPoweredConversations,
                    description: AppStrings.engageInRealLife,
                  ),
                  OnboardingPage(
                    animation: AppJson.onBoarding3,
                    title: AppStrings.speakWithConfidence,
                    description: AppStrings.getInstantFeedback,
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _goToMainScreen(),
                  child: const Text(AppStrings.skip),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      _goToMainScreen();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    isLastPage ? AppStrings.getStarted : AppStrings.next,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToMainScreen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingCompleted', true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }
}
