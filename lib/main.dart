import 'package:easy_lamp/localization_service.dart';
import 'package:easy_lamp/navigation_service.dart';
import 'package:easy_lamp/core/auth_token_storage/auth_token_storage.dart';
import 'package:easy_lamp/data/model/language_type.dart';
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
import 'package:easy_lamp/presenter/pages/auth_feature/auth_page.dart';
import 'package:easy_lamp/presenter/pages/blue_feather/blue_app.dart';
import 'package:easy_lamp/presenter/pages/splash_feature/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_lamp/core/config/theme_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:sizer/sizer.dart';

void main() async {
  if (!kIsWeb) FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
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

  if (!kIsWeb) {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print('connection disconnected');
      }
    });
  }

  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://cf0c5e8457825d3771594f7e11d146e7@sentry.hamravesh.com/6652';
      options.addIntegration(LoggingIntegration());

        },
    appRunner: () => runApp(const MyApp()),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                LocalizationService.selectedLocale =
                    state.languageType == LanguageType.PS ? Locale('fa', '') : Locale('en', '');
                LocalizationService.isLocalPersian =  LocalizationService.selectedLocale.languageCode == 'fa';

                return MaterialApp(
                  title: "Passary",
                  navigatorKey: NavigationService.navigatorKey, // set property
                  navigatorObservers: [
                    if (!kIsWeb) BluetoothAdapterStateObserver()
                  ],
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
                  locale: state.languageType == LanguageType.PS
                      ? const Locale('fa', '')
                      : const Locale('en', ''),
                  home: const SplashPage(),
                );
              },
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
