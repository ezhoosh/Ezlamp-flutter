import 'package:dio/dio.dart';
import 'package:easy_lamp/core/utils/local_data_provider.dart';
import 'package:easy_lamp/data/repositories/auth_repository_impl.dart';
import 'package:easy_lamp/data/repositories/local_storage_repositoryimpl.dart';
import 'package:easy_lamp/data/repositories/splash_repository_impl.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/refresh_token_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_verify_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_login_otp_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_phone_number_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;
setupMain() async {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<LocalDataProvider>(LocalDataProvider(locator()));
  locator.registerSingleton<LocalStorageRepository>(
      LocalStorageRepositoryImpl(locator()));
  locator.registerSingleton<WriteLocalStorageUseCase>(
      WriteLocalStorageUseCase(locator()));
  locator.registerSingleton<ReadLocalStorageUseCase>(
      ReadLocalStorageUseCase(locator()));
}

setupSplash() async {
  // repositories
  locator.registerSingleton<SplashRepository>(SplashRepositoryImpl());
  // usecases
  locator
      .registerSingleton<RefreshTokenUseCase>(RefreshTokenUseCase(locator()));
  //bloc
  locator.registerSingleton<SplashBloc>(SplashBloc(
    locator(),
    locator(),
    locator(),
  ));
}

setupAuth() async {
  // repositories
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // usecases
  locator.registerSingleton<LoginUseCase>(LoginUseCase(locator()));
  locator.registerSingleton<RegisterUseCase>(RegisterUseCase(locator()));
  locator.registerSingleton<SendPhoneNumberUseCase>(
      SendPhoneNumberUseCase(locator()));
  locator
      .registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(locator()));
  locator.registerSingleton<RegisterVerifyUseCase>(
      RegisterVerifyUseCase(locator()));
  locator
      .registerSingleton<SendLoginOtpUseCase>(SendLoginOtpUseCase(locator()));

  //bloc
  locator.registerSingleton<AuthBloc>(AuthBloc(
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
  ));
}
