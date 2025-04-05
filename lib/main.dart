import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:speak_up/app/repo.dart';
import 'package:speak_up/manager/ai_chat/ai_chat_cubit.dart';
import 'package:speak_up/manager/auth/auth_cubit.dart';
import 'package:speak_up/manager/bottom_nav/bottom_nav_cubit.dart';
import 'package:speak_up/manager/conversation/conversation_cubit.dart';
import 'package:speak_up/manager/onboarding/on_boarding_cubit.dart';
import 'package:speak_up/manager/settings/settings_cubit.dart';
import 'package:speak_up/manager/settings/settings_state.dart';
import 'package:speak_up/resources/constants.dart';
import 'package:speak_up/resources/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_KEY']!,
      )
      .then((_) {
        if (kDebugMode) {
          print("Supabase initialized successfully!");
        }
      })
      .catchError((error) {
        if (kDebugMode) {
          print("Error initializing Supabase: $error");
        }
      });

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppConstants.translationPath,
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BottomNavCubit()),
          BlocProvider(create: (_) => ConversationCubit()),
          BlocProvider(create: (_) => OnboardingCubit()),
          BlocProvider(create: (_) => AiChatCubit()),
          BlocProvider(create: (_) => SettingsCubit(Repository())),
          BlocProvider(
            create: (_) => AuthCubit(Supabase.instance.client, Repository()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: state.currentLocale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
