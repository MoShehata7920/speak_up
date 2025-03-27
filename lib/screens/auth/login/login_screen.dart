import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/widgets/app_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            SizedBox(height: size.height * 0.1),
            Hero(
              tag: 'logo',
              child: Center(
                child: Image.asset(
                  AppImages.appLogo,
                  height: size.height * 0.17,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.06),
            AppText(
              text: AppStrings.welcomeBack.tr(),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: size.height * 0.01),
            AppText(text: AppStrings.loginToContinue.tr(), color: Colors.grey),
            SizedBox(height: size.height * 0.04),
            _buildTextField(label: AppStrings.email.tr()),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.password.tr(), isPassword: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                },
                child: Text(AppStrings.forgotPassword.tr()),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppStrings.login.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.signUpRoute);
              },
              child: Text(AppStrings.dontHaveAccount.tr()),
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
