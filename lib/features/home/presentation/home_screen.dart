import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speak_up/core/assets_manager.dart';
import 'package:speak_up/core/icons_manager.dart';
import 'package:speak_up/core/strings_manager.dart';
import 'package:speak_up/core/app_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "${AppStrings.welcome.tr()} Torky!",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: size.width * 0.12,
              height: size.width * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppImages.myPic),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAIChatCard(size),
            _buildDailyLearningCard(),
            _buildConversationPracticeCard(),
            _buildProgressTrackerCard(size),
          ],
        ),
      ),
    );
  }

  Widget _buildAIChatCard(Size size) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Lottie.asset(AppJson.onBoarding2, height: size.height * 0.1),
            AppText(
              text: AppStrings.talkToAI.tr(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: AppStrings.improveYourSkills.tr(),
              textAlign: TextAlign.center,
              fontSize: 14,
              color: Colors.grey,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppStrings.startChat.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyLearningCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(AppIcons.light, color: Colors.orange, size: 30),
        title: AppText(
          text: AppStrings.wordOfTheDay.tr(),
          fontWeight: FontWeight.bold,
        ),
        subtitle: AppText(
          text: "Bonjour (Hello in French)",
          color: Colors.grey,
        ),
        trailing: IconButton(
          icon: const Icon(AppIcons.volumeUp),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildConversationPracticeCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              AppIcons.conversations,
              color: Colors.blue,
              size: 30,
            ),
            title: AppText(
              text: AppStrings.conversationPractice.tr(),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          _conversationItem("Ordering at a Restaurant", "🇺🇸 English"),
          _conversationItem("Asking for Directions", "🇫🇷 French"),
          _conversationItem("Booking a Hotel", "🇩🇪 German"),
        ],
      ),
    );
  }

  Widget _conversationItem(String title, String language) {
    return ListTile(
      title: AppText(text: title, fontWeight: FontWeight.w500),
      subtitle: AppText(text: language, color: Colors.grey),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text(AppStrings.start.tr()),
      ),
    );
  }

  Widget _buildProgressTrackerCard(Size size) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppText(
              text: AppStrings.yourProgress.tr(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: "${AppStrings.streak.tr()} 5 ${AppStrings.days.tr()}",
              fontSize: 16,
              color: Colors.redAccent,
            ),
            LinearProgressIndicator(value: 0.6),
            AppText(
              text: "60% ${AppStrings.completed.tr()}",
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
