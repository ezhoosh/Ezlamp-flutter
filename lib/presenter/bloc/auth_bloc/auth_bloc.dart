import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/auth_token_storage/auth_token_storage.dart';
import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/language_type.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/usecases/change_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_language_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_verify_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_otp_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_login_otp_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_phone_number_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:meta/meta.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordOtpUseCase resetPasswordOtpUseCase;
  SendPhoneNumberUseCase sendPhoneNumberUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  ReadLocalStorageUseCase readLocalStorageUseCase;
  RegisterVerifyUseCase registerVerifyUseCase;
  SendLoginOtpUseCase sendLoginOtpUseCase;
  ChangePasswordUseCase changePasswordUseCase;
  ReadConnectionUseCase readConnectionUseCase;
  ReadLanguageUseCase readLanguageUseCase;

  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
    this.resetPasswordUseCase,
    this.sendPhoneNumberUseCase,
    this.writeLocalStorageUseCase,
    this.readLocalStorageUseCase,
    this.registerVerifyUseCase,
    this.sendLoginOtpUseCase,
    this.changePasswordUseCase,
    this.readConnectionUseCase,
    this.readLanguageUseCase,
    this.resetPasswordOtpUseCase
  ) : super(AuthState(
          loginStatus: BaseNoAction(),
          registerStatus: BaseNoAction(),
          resetPasswordStatus: BaseNoAction(),
          sendPhoneStatus: BaseNoAction(),
          registerVerifyStatus: BaseNoAction(),
          sendLoginOtpStatus: BaseNoAction(),
          sendResetOtpStatus: BaseNoAction(),
          changePasswordStatus: BaseNoAction(),
          logOutStatus: BaseNoAction(),
          connectionType: ConnectionType.Internet,
          languageType: LanguageType.PS,
          resetPostPasswordStatus: BaseNoAction()
        )) {
    on<SendPhoneNumberEvent>((event, emit) async {
      emit(state.copyWith(newSendPhoneStatus: BaseLoading()));
      DataState dataState =
          await sendPhoneNumberUseCase(SendPhoneNumberParams(event.number));
      if (dataState is DataSuccess) {
        emit(state.copyWith(newSendPhoneStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newSendPhoneStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(newLoginStatus: BaseLoading()));
      DataState dataState = await loginUseCase(
          LoginParams(event.number, smsToken: event.otp, password: event.password));
      if (dataState is DataSuccess) {
        LoginModel model = dataState.data;
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.accessKey, model.access));
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.refreshKey, model.refresh));
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.phoneKey, model.phoneNumber));
        AuthTokenStorage.instance.save(dataState.data);

        emit(state.copyWith(newLoginStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newLoginStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newLoginStatus: BaseNoAction()));
    });
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(newRegisterStatus: BaseLoading()));
      DataState dataState = await registerUseCase(
          LoginParams(event.number, smsToken: event.otp, password: event.password));
      if (dataState is DataSuccess) {
        LoginModel model = dataState.data;
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.accessKey, model.access));
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.refreshKey, model.refresh));
        await writeLocalStorageUseCase(
            WriteLocalStorageParam(Constants.phoneKey, model.phoneNumber));
        AuthTokenStorage.instance.save(dataState.data);
        emit(state.copyWith(newRegisterStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newRegisterStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(state.copyWith(newResetPasswordStatus: BaseLoading()));
      DataState dataState = await resetPasswordUseCase(
          LoginParams(event.number, smsToken: event.otp));
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newResetPasswordStatus: BaseSuccess(dataState.data)));
      } else {
        emit(
            state.copyWith(newResetPasswordStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });

    on<PostResetPasswordEvent>((event, emit) async {
      emit(state.copyWith(newResetPostPasswordStatus: BaseLoading()));
      DataState dataState = await resetPasswordUseCase(
          LoginParams(event.number,password: event.password));
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newResetPostPasswordStatus: BaseSuccess(dataState.data)));
      } else {
        emit(
            state.copyWith(newResetPostPasswordStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newResetPostPasswordStatus: BaseNoAction()));
    });

    on<ResetPasswordOtpEvent>((event, emit) async {
      emit(state.copyWith(newResetPasswordStatus: BaseLoading()));
      DataState dataState = await resetPasswordOtpUseCase(
          LoginParams(event.number, smsToken: event.otp));
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newResetPasswordStatus: BaseSuccess(dataState.data)));
      } else {
        emit(
            state.copyWith(newResetPasswordStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<RegisterVerifyEvent>((event, emit) async {
      emit(state.copyWith(newRegisterVerifyStatus: BaseLoading()));
      DataState dataState = await registerVerifyUseCase(
          RegisterVerifyParams(event.number, event.otp));
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newRegisterVerifyStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newRegisterVerifyStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newRegisterVerifyStatus: BaseNoAction()));
    });

    on<SendLoginOtpEvent>((event, emit) async {
      emit(state.copyWith(newSendLoginOtpStatus: BaseLoading()));
      DataState dataState = await sendLoginOtpUseCase(event.number);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newSendLoginOtpStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newSendLoginOtpStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendLoginOtpStatus: BaseNoAction()));
    });

    on<SendResetOtpEvent>((event, emit) async {
      emit(state.copyWith(newSendResetOtpStatus: BaseLoading()));
      DataState dataState = await sendLoginOtpUseCase(event.number);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newSendResetOtpStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newSendResetOtpStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendResetOtpStatus: BaseNoAction()));
    });
    on<ChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(newChangePasswordStatus: BaseLoading()));
      DataState dataState = await changePasswordUseCase(
          ChangePasswordParams(event.oldPassword, event.newPassword));
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newChangePasswordStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newChangePasswordStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newChangePasswordStatus: BaseNoAction()));
    });
    on<LogOutEvent>((event, emit) async {
      await writeLocalStorageUseCase(
          WriteLocalStorageParam(Constants.accessKey, ''));
      await writeLocalStorageUseCase(
          WriteLocalStorageParam(Constants.refreshKey, ''));
      await writeLocalStorageUseCase(
          WriteLocalStorageParam(Constants.phoneKey, ''));
      await AuthTokenStorage.instance.delete();
      emit(state.copyWith(newLogOutStatus: BaseSuccess(null)));
      emit(state.copyWith(newLogOutStatus: BaseNoAction()));
    });
    on<ChangeConnectionTypeEvent>((event, emit) async {
      await writeLocalStorageUseCase(WriteLocalStorageParam(
          Constants.connectionTypeKey, event.type.toString()));
      add(GetConnectionTypeEvent());
    });
    on<GetConnectionTypeEvent>((event, emit) async {
      ConnectionType type = await readConnectionUseCase(NoParams());
      emit(state.copyWith(newConnectionType: type));
    });
    on<GetLanguageTypeEvent>((event, emit) async {
      LanguageType type = await readLanguageUseCase(NoParams());
      emit(state.copyWith(newLanguageType: type));
    });
    on<ChangeLanguageTypeEvent>((event, emit) async {
      await writeLocalStorageUseCase(
          WriteLocalStorageParam(Constants.languageKey, event.type.toString()));
      add(GetLanguageTypeEvent());
    });
  }
}
