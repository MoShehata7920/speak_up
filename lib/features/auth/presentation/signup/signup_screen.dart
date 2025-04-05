import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:speak_up/features/auth/presentation/cubit/auth_state.dart';
import 'package:speak_up/core/assets_manager.dart';
import 'package:speak_up/core/routes_manager.dart';
import 'package:speak_up/core/strings_manager.dart';
import 'package:speak_up/core/app_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is SignUpAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.signUpSuccess.tr()),
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
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is SignUpLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                  AppText(
                    text: AppStrings.signUpToContinue.tr(),
                    color: Colors.grey,
                  ),
                  SizedBox(height: size.height * 0.04),
                  _buildTextField(
                    label: AppStrings.fullName.tr(),
                    controller: _fullNameController,
                    focusNode: _fullNameFocus,
                    nextFocusNode: _emailFocus,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppStrings.pleasEnterYourName.tr()
                                : null,
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextField(
                    label: AppStrings.email.tr(),
                    controller: _emailController,
                    focusNode: _emailFocus,
                    nextFocusNode: _passwordFocus,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppStrings.pleasEnterYourEmail
                                : null,
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextField(
                    label: AppStrings.password.tr(),
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    isPassword: true,
                    validator:
                        (value) =>
                            value!.length < 6
                                ? AppStrings.passwordNotValid
                                : null,
                  ),
                  SizedBox(height: size.height * 0.04),
                  ElevatedButton(
                    onPressed: isLoading ? null : _signUp,
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
                            : Text(AppStrings.signUp.tr()),
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
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      focusNode: focusNode,
      onEditingComplete: () {
        if (isPassword) {
          _signUp();
        } else if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      controller: controller,
      decoration: InputDecoration(labelText: label),
      obscureText: isPassword,
      validator: validator,
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _fullNameController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}
