import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';

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
            Text(
              AppStrings.createAccount,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              AppStrings.signUpToContinue,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: size.height * 0.04),
            _buildTextField(label: AppStrings.fullName),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.email),
            SizedBox(height: size.height * 0.02),
            _buildTextField(label: AppStrings.password, isPassword: true),
            SizedBox(height: size.height * 0.04),
            ElevatedButton(
              onPressed: () {},
              child: const Text(AppStrings.signUp),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(AppStrings.alreadyHaveAccount),
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
