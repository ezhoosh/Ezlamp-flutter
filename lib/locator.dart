import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/utils/local_data_provider.dart';
import 'package:easy_lamp/data/isar_model/isar_command.dart';
import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_internet_box.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:easy_lamp/data/isar_model/isar_owner.dart';
import 'package:easy_lamp/data/repositories/auth_repository_impl.dart';
import 'package:easy_lamp/data/repositories/command_repository_impl.dart';
import 'package:easy_lamp/data/repositories/invitation_repository_impl.dart';
import 'package:easy_lamp/data/repositories/isar_group_repository.dart';
import 'package:easy_lamp/data/repositories/group_repository_impl.dart';
import 'package:easy_lamp/data/repositories/internet_box_repository_impl.dart';
import 'package:easy_lamp/data/repositories/isar_internet_box_repository.dart';
import 'package:easy_lamp/data/repositories/isar_lamp_repository.dart';
import 'package:easy_lamp/data/repositories/local_storage_repositoryimpl.dart';
import 'package:easy_lamp/data/repositories/splash_repository_impl.dart';
import 'package:easy_lamp/data/repositories/state_repository_impl.dart';
import 'package:easy_lamp/data/repositories/user_repository_impl.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/command_repository.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/data/repositories/lamp_repository_impl.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';
import 'package:easy_lamp/domain/repositories/state_repository.dart';
import 'package:easy_lamp/domain/repositories/user_repository.dart';
import 'package:easy_lamp/domain/usecases/accept_invite_usecase.dart';
import 'package:easy_lamp/domain/usecases/change_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/create_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/create_invitation_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/decline_invite_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_internet_box_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_data_state_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_by_group_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_invitation_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_my_invitation_assignment_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/patch_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/patch_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/put_invitation_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
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
import 'package:easy_lamp/presenter/bloc/invitation_bloc/invitation_bloc.dart';
import 'package:easy_lamp/presenter/bloc/lamp_bloc/lamp_bloc.dart';
import 'package:easy_lamp/presenter/bloc/splash_bloc/splash_bloc.dart';
import 'package:easy_lamp/presenter/bloc/state_bloc/state_bloc.dart';
import 'package:easy_lamp/presenter/bloc/user_bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;

setupMain() async {
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<Isar>(await openDB());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<LocalDataProvider>(LocalDataProvider(locator()));
  locator.registerSingleton<LocalStorageRepository>(
      LocalStorageRepositoryImpl(locator()));
  locator.registerSingleton<WriteLocalStorageUseCase>(
      WriteLocalStorageUseCase(locator()));
  locator.registerSingleton<ReadLocalStorageUseCase>(
      ReadLocalStorageUseCase(locator()));
  locator.registerSingleton<ReadConnectionUseCase>(
      ReadConnectionUseCase(locator()));
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
    locator(),
  ));
}

setupGroup() async {
  // repositories
  locator.registerSingleton<GroupRepository>(GroupRepositoryImpl());
  locator
      .registerSingleton<IsarGroupRepository>(IsarGroupRepository(locator()));
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
  locator.registerSingleton<IsarInternetBoxRepository>(
      IsarInternetBoxRepository(locator()));

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
  locator.registerSingleton<IsarLampRepository>(IsarLampRepository(locator()));
  locator.registerSingleton<PatchLampUseCase>(PatchLampUseCase(locator()));

  //bloc
  locator.registerSingleton<LampBloc>(LampBloc(
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

setupState() async {
  // repositories
  locator.registerSingleton<StateRepository>(StateRepositoryImpl());
  // useCases
  locator
      .registerSingleton<GetDataStateUseCase>(GetDataStateUseCase(locator()));
  //bloc
  locator.registerSingleton<StateBloc>(StateBloc(locator()));
}

setupInvitation() async {
  // repositories
  locator.registerSingleton<InvitationRepository>(InvitationRepositoryImpl());
  // useCases
  locator.registerSingleton<GetInvitationListUseCase>(
      GetInvitationListUseCase(locator()));
  locator.registerSingleton<GetMyInvitationAssignmentListUseCase>(
      GetMyInvitationAssignmentListUseCase(locator()));
  locator.registerSingleton<GetInvitationByIdUseCase>(
      GetInvitationByIdUseCase(locator()));
  locator.registerSingleton<GetInvitationByGroupIdUseCase>(
      GetInvitationByGroupIdUseCase(locator()));
  locator.registerSingleton<DeleteInvitationUseCase>(
      DeleteInvitationUseCase(locator()));
  locator.registerSingleton<CreateInvitationUseCase>(
      CreateInvitationUseCase(locator()));
  locator
      .registerSingleton<PutInvitationUseCase>(PutInvitationUseCase(locator()));
  locator
      .registerSingleton<AcceptInviteUseCase>(AcceptInviteUseCase(locator()));
  locator
      .registerSingleton<DeclineInviteUseCase>(DeclineInviteUseCase(locator()));
  locator.registerSingleton<PatchInvitationUseCase>(
      PatchInvitationUseCase(locator()));
  //bloc
  locator.registerSingleton<InvitationBloc>(InvitationBloc(
    locator(),
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

Future<Isar> openDB() async {
  if (Isar.instanceNames.isEmpty) {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    await Directory('${appDocDirectory.path}/dir').create(recursive: true);
    Isar isar = await Isar.open(
      [
        IsarLampSchema,
        IsarGroupSchema,
        IsarCommandSchema,
        IsarOwnerSchema,
        IsarInternetBoxSchema,
      ],
      inspector: true,
      directory: '${appDocDirectory.path}/dir',
    );
    return isar;
  }

  return Future.value(Isar.getInstance());
}
