import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speak_up/manager/onboarding/on_boarding_cubit.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/screens/on_boarding/on_boarding_page.dart';
import 'package:speak_up/service/utils.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    Size size = Utils(context).screenSize;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged:
                    (index) =>
                        context.read<OnboardingCubit>().updatePage(index),
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
              controller: controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            BlocBuilder<OnboardingCubit, int>(
              builder: (context, currentIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => completeOnboarding(context),
                      child: const Text(AppStrings.skip),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (context.read<OnboardingCubit>().isLastPage()) {
                          completeOnboarding(context);
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        context.read<OnboardingCubit>().isLastPage()
                            ? AppStrings.getStarted
                            : AppStrings.next,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);

    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, Routes.logInRoute);
  }
}
