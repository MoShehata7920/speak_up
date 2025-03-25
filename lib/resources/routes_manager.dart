import 'package:flutter/material.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:speak_up/screens/auth/login/login_screen.dart';
import 'package:speak_up/screens/auth/signup/signup_screen.dart';
import 'package:speak_up/screens/home/main_screen.dart';
import 'package:speak_up/screens/main/nav_bar.dart';
import 'package:speak_up/screens/on_boarding/on_boarding_screen.dart';
import 'package:speak_up/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoardingRoute';
  static const String mainRoute = '/mainRoute';
  static const String logInRoute = '/logInRoute';
  static const String signUpRoute = '/signUpRoute';
  static const String forgotPasswordRoute = '/forgotPasswordRoute';
  static const String navBarRoute = '/navBarRoute';
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

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.logInRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case Routes.navBarRoute:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (context) => Scaffold(
            appBar: AppBar(title: const Text(AppStrings.noRouteTitle)),
            body: const Center(child: Text(AppStrings.noRouteFound)),
          ),
    );
  }
}
