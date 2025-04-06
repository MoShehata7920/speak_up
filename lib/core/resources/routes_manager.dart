import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:speak_up/core/resources/strings_manager.dart';
import 'package:speak_up/features/auth/presentation/forgot_password/forgot_password_screen.dart';
import 'package:speak_up/features/auth/presentation/login/login_screen.dart';
import 'package:speak_up/features/auth/presentation/signup/signup_screen.dart';
import 'package:speak_up/features/main/presentation/nav_bar.dart';
import 'package:speak_up/features/on_boarding/presentation/on_boarding_screen.dart';
import 'package:speak_up/features/settings/presentation/edit_profile_screen.dart';
import 'package:speak_up/features/splash/presentation/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String logInRoute = '/logInRoute';
  static const String signUpRoute = '/signUpRoute';
  static const String forgotPasswordRoute = '/forgotPasswordRoute';
  static const String navBarRoute = '/navBarRoute';
  static const String editProfileRoute = '/editProfileRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );

      case Routes.logInRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case Routes.navBarRoute:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());

      case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (context) => Scaffold(
            appBar: AppBar(title: Text(AppStrings.noRouteTitle.tr())),
            body: Center(child: Text(AppStrings.noRouteFound.tr())),
          ),
    );
  }
}
