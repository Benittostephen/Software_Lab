import 'package:flutter/material.dart';
import 'package:software_lab/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'BeVietnam',
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFD5715B)),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
      home: const SplashScreen(),
    );
  }
}