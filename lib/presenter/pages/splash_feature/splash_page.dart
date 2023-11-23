import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/my_spaces.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_status.dart';
import 'package:easy_lamp/presenter/pages/blue_feather/blue_app.dart';
import 'package:easy_lamp/presenter/pages/home_feature/home_page.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/connection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // double h = MediaQuery.of(context).size.height;

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.checkLoginStatus is SplashSuccessWithOutBlue) {
          if ((state.checkLoginStatus as SplashSuccessWithOutBlue).entity) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            gotoAuth();
          }
        } else if (state.checkLoginStatus is SplashSuccessWithBlue) {
          if ((state.checkLoginStatus as SplashSuccessWithBlue).entity) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ConnectionPage()),
            );
          } else {
            gotoAuth();
          }
        } else if (state.checkLoginStatus is SplashError) {
          gotoAuth();
        }
      },
      child: Container(
        color: MyColors.black.shade700,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/icons/splash_logo.png',
                    width: w * 0.5,
                    height: w * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const CircularProgressIndicator(
                color: MyColors.primary,
              ),
              const SizedBox(
                height: MySpaces.s40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      BlocProvider.of<SplashBloc>(context).add(CheckLoginEvent());
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => AuthPage()),
      // );
    });
    BlocProvider.of<AuthBloc>(context).add(GetLanguageTypeEvent());
  }

  gotoAuth() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
  }
}
