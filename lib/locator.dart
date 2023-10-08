import 'package:dio/dio.dart';
import 'package:easy_lamp/core/utils/local_data_provider.dart';
import 'package:easy_lamp/data/repositories/auth_repository_impl.dart';
import 'package:easy_lamp/data/repositories/command_repository_impl.dart';
import 'package:easy_lamp/data/repositories/group_repository_impl.dart';
import 'package:easy_lamp/data/repositories/internet_box_repository_impl.dart';
import 'package:easy_lamp/data/repositories/local_storage_repositoryimpl.dart';
import 'package:easy_lamp/data/repositories/splash_repository_impl.dart';
import 'package:easy_lamp/data/repositories/user_repository_impl.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/command_repository.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/data/repositories/lamp_repository_impl.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';
import 'package:easy_lamp/domain/repositories/user_repository.dart';
import 'package:easy_lamp/domain/usecases/change_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/create_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_internet_box_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/refresh_token_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_verify_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_command_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_login_otp_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_phone_number_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_name_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_internet_box_name_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_internet_box_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_internet_box_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_lamp_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:easy_lamp/presenter/bloc/auth_bloc/auth_bloc.dart';
import 'package:easy_lamp/presenter/bloc/command_bloc/command_bloc.dart';
import 'package:easy_lamp/presenter/bloc/group_bloc/group_bloc.dart';
import 'package:easy_lamp/presenter/bloc/internet_box_bloc/internet_box_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:easy_lamp/presenter/bloc/user_bloc/user_bloc.dart';
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
  locator.registerSingleton<ChangePasswordUseCase>(
      ChangePasswordUseCase(locator()));

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
    locator(),
  ));
}

setupGroup() async {
  // repositories
  locator.registerSingleton<GroupRepository>(GroupRepositoryImpl());
  // useCases
  locator
      .registerSingleton<GetGroupListUseCase>(GetGroupListUseCase(locator()));
  locator
      .registerSingleton<GetGroupByIdUseCase>(GetGroupByIdUseCase(locator()));
  locator.registerSingleton<UpdateGroupOwnerUseCase>(
      UpdateGroupOwnerUseCase(locator()));
  locator.registerSingleton<UpdateGroupUseCase>(UpdateGroupUseCase(locator()));
  locator.registerSingleton<DeleteGroupUseCase>(DeleteGroupUseCase(locator()));
  locator.registerSingleton<CreateGroupUseCase>(CreateGroupUseCase(locator()));
  locator.registerSingleton<UpdateGroupNameUseCase>(
      UpdateGroupNameUseCase(locator()));

  //bloc
  locator.registerSingleton<GroupBloc>(GroupBloc(
    locator(),
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

setupInternetBox() async {
  // repositories
  locator.registerSingleton<InternetBoxRepository>(InternetBoxRepositoryImpl());
  // useCases
  locator.registerSingleton<GetInternetBoxListUseCase>(
      GetInternetBoxListUseCase(locator()));
  locator.registerSingleton<GetInternetBoxByIdUseCase>(
      GetInternetBoxByIdUseCase(locator()));
  locator.registerSingleton<UpdateInternetBoxOwnerUseCase>(
      UpdateInternetBoxOwnerUseCase(locator()));
  locator.registerSingleton<UpdateInternetBoxUseCase>(
      UpdateInternetBoxUseCase(locator()));
  locator.registerSingleton<DeleteInternetBoxUseCase>(
      DeleteInternetBoxUseCase(locator()));
  locator.registerSingleton<UpdateInternetBoxNameUseCase>(
      UpdateInternetBoxNameUseCase(locator()));

  //bloc
  locator.registerSingleton<InternetBoxBloc>(InternetBoxBloc(
    locator(),
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

setupLamp() async {
  // repositories
  locator.registerSingleton<LampRepository>(LampRepositoryImpl());
  // useCases
  locator.registerSingleton<GetLampListUseCase>(GetLampListUseCase(locator()));
  locator.registerSingleton<GetLampByIdUseCase>(GetLampByIdUseCase(locator()));
  locator.registerSingleton<UpdateLampOwnerUseCase>(
      UpdateLampOwnerUseCase(locator()));
  locator.registerSingleton<UpdateLampUseCase>(UpdateLampUseCase(locator()));
  locator.registerSingleton<DeleteLampUseCase>(DeleteLampUseCase(locator()));

  //bloc
  locator.registerSingleton<LampBloc>(LampBloc(
    locator(),
    locator(),
    locator(),
    locator(),
    locator(),
  ));
}

setupUser() async {
  // repositories
  locator.registerSingleton<UserRepository>(UserRepositoryImpl());
  // useCases
  locator.registerSingleton<GetUserUseCase>(GetUserUseCase(locator()));
  locator.registerSingleton<UpdateUserUseCase>(UpdateUserUseCase(locator()));
  //bloc
  locator.registerSingleton<UserBloc>(UserBloc(
    locator(),
    locator(),
  ));
}

setupCommand() async {
  // repositories
  locator.registerSingleton<CommandRepository>(CommandRepositoryImpl());
  // useCases
  locator.registerSingleton<SendCommandUseCase>(SendCommandUseCase(locator()));
  //bloc
  locator.registerSingleton<CommandBloc>(CommandBloc(
    locator(),
  ));
}
