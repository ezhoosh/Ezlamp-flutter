import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/utils/local_data_provider.dart';
import 'package:easy_lamp/data/repositories/auth_repository_impl.dart';
import 'package:easy_lamp/data/repositories/local_storage_repositoryimpl.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_phone_number_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;
setupMain() async{
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  locator.registerSingleton<LocalDataProvider>(LocalDataProvider(locator()));
  locator.registerSingleton<LocalStorageRepository>(LocalStorageRepositoryImpl(locator()));
  locator.registerSingleton<WriteLocalStorageUseCase>(WriteLocalStorageUseCase(locator()));
  locator.registerSingleton<ReadLocalStorageUseCase>(ReadLocalStorageUseCase(locator()));
}

setupSplash() async {
  locator.registerSingleton<SplashBloc>(SplashBloc());
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

  //bloc
  locator.registerSingleton<AuthBloc>(AuthBloc(
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
  ));
}
