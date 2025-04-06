import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:speak_up/core/app_text.dart';
import 'package:speak_up/core/assets_manager.dart';
import 'package:speak_up/core/routes_manager.dart';
import 'package:speak_up/core/strings_manager.dart';
import 'package:speak_up/core/utils.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is LoginAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.loginSuccessful.tr()),
                duration: const Duration(seconds: 1),
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.navBarRoute,
                  (route) => false,
                );
              }
            });
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                  AppText(
                    text: AppStrings.loginToContinue.tr(),
                    color: Colors.grey,
                  ),
                  SizedBox(height: size.height * 0.04),
                  _buildTextField(
                    label: AppStrings.email.tr(),
                    focusNode: _emailFocus,
                    nextFocusNode: _passwordFocus,
                    controller: _emailController,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppStrings.pleasEnterYourEmail
                                : null,
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextField(
                    label: AppStrings.password.tr(),
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    isPassword: true,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppStrings.pleaseEnterYourPassword.tr()
                                : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.forgotPasswordRoute,
                        );
                      },
                      child: Text(AppStrings.forgotPassword.tr()),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ElevatedButton(
                    onPressed: isLoading ? null : _signIn,
                    child:
                        isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : Text(AppStrings.login.tr()),
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
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: () {
        if (isPassword) {
          _signIn();
        } else if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
      validator: validator,
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().logIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}
