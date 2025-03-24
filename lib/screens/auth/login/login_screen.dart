import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';

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
            Text(
              AppStrings.welcomeBack,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              AppStrings.loginToContinue,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: size.height * 0.04),
            _buildTextField(label: AppStrings.email),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.password, isPassword: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                },
                child: const Text(AppStrings.forgotPassword),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            ElevatedButton(
              onPressed: () {},
              child: const Text(AppStrings.login),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.signUpRoute);
              },
              child: const Text(AppStrings.dontHaveAccount),
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
