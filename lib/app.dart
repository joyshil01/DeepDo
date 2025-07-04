import 'package:flutter/material.dart';

import 'screens/login/authScreen.dart';
import 'screens/aiChat/chatScreen.dart';
import 'screens/room/coWorkingScreen.dart';
import 'screens/home/focusTimerScreen.dart';
import 'screens/notification/notificationScreen.dart';
import 'screens/social/socialScreen.dart';
import 'screens/login/welcomeScreen.dart';
import 'widgets/bottomNav.dart';

class DeepDoApp extends StatelessWidget {
  const DeepDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'DeepDo',
      title: 'DeepDo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthScreen(),
        '/main_wrapper': (context) => MainWrapper(0),
        '/focus_timer': (context) => const FocusTimerScreen(),
        '/ai_assistant': (context) => const AiAssistantScreen(),
        '/coworking_rooms': (context) => const CoWorkingRoomsScreen(),
        '/social_gamification': (context) => const SocialGamificationScreen(),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}
