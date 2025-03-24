import 'package:flutter/material.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/screens/main/main_screen.dart';
import 'package:speak_up/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String mainRoute = '/mainRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (context) => const MainScreen());

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
