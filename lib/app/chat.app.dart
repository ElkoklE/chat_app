import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_app/screens/auth.screen.dart';
import 'package:chat_app/screens/chat.screen.dart';
import 'package:chat_app/screens/splash.screen.dart';

class ChatApp extends StatelessWidget {
  ChatApp({super.key});

  final ThemeData theme = ThemeData().copyWith(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 63, 17, 177),
    ),
  );

  final ThemeData darkTheme = ThemeData().copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 63, 17, 177),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VBlizosti",
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
