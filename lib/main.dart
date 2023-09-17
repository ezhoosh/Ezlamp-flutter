import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/config/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeConfig.lightTheme,
      home: const SplashPage(),
    );
  }
}
