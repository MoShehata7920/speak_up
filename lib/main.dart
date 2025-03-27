import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speak_up/manager/ai_chat/ai_chat_cubit.dart';
import 'package:speak_up/manager/bottom_nav/bottom_nav_cubit.dart';
import 'package:speak_up/manager/conversation/conversation_cubit.dart';
import 'package:speak_up/manager/onboarding/on_boarding_cubit.dart';
import 'package:speak_up/manager/settings/settings_cubit.dart';
import 'package:speak_up/manager/settings/settings_state.dart';
import 'package:speak_up/resources/constants.dart';
import 'package:speak_up/resources/routes_manager.dart';
import 'package:speak_up/screens/settings/data/settings_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
          BlocProvider(create: (_) => SettingsCubit(SettingsRepository())),
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
