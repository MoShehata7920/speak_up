import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/manager/bottom_nav/bottom_nav_cubit.dart';
import 'package:speak_up/manager/conversation/conversation_cubit.dart';
import 'package:speak_up/manager/onboarding/on_boarding_cubit.dart';
import 'package:speak_up/resources/routes_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => ConversationCubit()),
        BlocProvider(create: (context) => OnboardingCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
