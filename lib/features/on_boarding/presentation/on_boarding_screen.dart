import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speak_up/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:speak_up/core/resources/assets_manager.dart';
import 'package:speak_up/core/resources/routes_manager.dart';
import 'package:speak_up/core/resources/strings_manager.dart';
import 'package:speak_up/features/on_boarding/presentation/on_boarding_page.dart';
import 'package:speak_up/core/resources/utils.dart';

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
                children:  [
                  OnboardingPage(
                    animation: AppJson.onBoarding1,
                    title: AppStrings.learnLanguagesEasy.tr(),
                    description: AppStrings.practiceConversations.tr(),
                  ),
                  OnboardingPage(
                    animation: AppJson.onBoarding2,
                    title: AppStrings.aiPoweredConversations.tr(),
                    description: AppStrings.engageInRealLife.tr(),
                  ),
                  OnboardingPage(
                    animation: AppJson.onBoarding3,
                    title: AppStrings.speakWithConfidence.tr(),
                    description: AppStrings.getInstantFeedback.tr(),
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
                      child: Text(AppStrings.skip.tr()),
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
                            ? AppStrings.getStarted.tr()
                            : AppStrings.next.tr(),
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
