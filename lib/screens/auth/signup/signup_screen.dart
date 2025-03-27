import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/widgets/app_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.07),
            Hero(
              tag: 'logo',
              child: Center(
                child: Image.asset(
                  AppImages.appLogo,
                  height: size.height * 0.15,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.1),
            AppText(
              text: AppStrings.createAccount.tr(),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),

            SizedBox(height: size.height * 0.01),
            AppText(text: AppStrings.signUpToContinue.tr(), color: Colors.grey),
            SizedBox(height: size.height * 0.04),
            _buildTextField(label: AppStrings.fullName.tr()),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.email.tr()),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.password.tr(), isPassword: true),
            SizedBox(height: size.height * 0.04),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppStrings.signUp.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppStrings.alreadyHaveAccount.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool isPassword = false}) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
    );
  }
}
