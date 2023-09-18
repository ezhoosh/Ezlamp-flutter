import 'package:easy_lamp/locator.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/config/theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';

void main() async {
  await setupMain();
  await setupSplash();
  await setupAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<SplashBloc>()),
        BlocProvider(create: (_) => locator<AuthBloc>()),
      ],
      child: FlutterWebFrame(
        builder: (BuildContext context) {
          return MaterialApp(
            builder: EasyLoading.init(),
            theme: ThemeConfig.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fa', ''),
            ],
            locale: const Locale('fa', ''),
            home: const SplashPage(),
          );
        },
        maximumSize: const Size(450.0, 812),
        enabled: kIsWeb,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
