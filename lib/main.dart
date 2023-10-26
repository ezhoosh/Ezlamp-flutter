import 'package:easy_lamp/data/model/schudule_model.dart';
import 'package:easy_lamp/locator.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:easy_lamp/presenter/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:easy_lamp/presenter/bloc/user_bloc/user_bloc.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/config/theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupMain();
  await setupSplash();
  await setupAuth();
  await setupGroup();
  await setupLamp();
  await setupUser();
  await setupInternetBox();
  await setupCommand();
  await setupState();
  await setupInvitation();
  await setupSchedule();

  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('connection disconnected');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('fa', '');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<SplashBloc>()),
        BlocProvider(create: (_) => locator<AuthBloc>()),
        BlocProvider(create: (_) => locator<GroupBloc>()),
        BlocProvider(create: (_) => locator<LampBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()),
        BlocProvider(create: (_) => locator<InternetBoxBloc>()),
        BlocProvider(create: (_) => locator<CommandBloc>()),
        BlocProvider(create: (_) => locator<StateBloc>()),
        BlocProvider(create: (_) => locator<InvitationBloc>()),
        BlocProvider(create: (_) => locator<ScheduleBloc>()),
      ],
      child: Sizer(builder: (context, w, e) {
        return FlutterWebFrame(
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
              locale: _locale,
              home: const SplashPage(),
            );
          },
          maximumSize: const Size(450.0, 812),
          enabled: kIsWeb,
          backgroundColor: Colors.grey,
        );
      }),
    );
  }
}
