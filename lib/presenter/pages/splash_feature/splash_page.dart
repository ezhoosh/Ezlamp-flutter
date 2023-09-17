import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_lamp/core/resource/my_colors.dart';
import 'package:easy_lamp/presenter/pages/auth_feature/auth_page.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      color: MyColors.black.shade700,
      child: Center(
        child: Image.asset(
          'assets/icons/splash_logo.png',
          width: w * 0.5,
          height: w * 0.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    });
  }
}
