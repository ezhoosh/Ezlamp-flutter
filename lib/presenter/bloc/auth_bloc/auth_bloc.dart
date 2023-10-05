import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/usecases/change_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_verify_usecase.dart';
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
  SendPhoneNumberUseCase sendPhoneNumberUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  ReadLocalStorageUseCase readLocalStorageUseCase;
  RegisterVerifyUseCase registerVerifyUseCase;
  SendLoginOtpUseCase sendLoginOtpUseCase;
  ChangePasswordUseCase changePasswordUseCase;

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
        )) {
    on<SendPhoneNumberEvent>((event, emit) async {
      emit(state.copyWith(newSendPhoneStatus: BaseLoading()));
      try {
        DataState dataState =
            await sendPhoneNumberUseCase(SendPhoneNumberParams(event.number));
        if (dataState is DataSuccess) {
          emit(state.copyWith(newSendPhoneStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(newSendPhoneStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newSendPhoneStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(newLoginStatus: BaseLoading()));
      try {
        DataState dataState = await loginUseCase(
            LoginParams(event.number, event.password, event.otp));
        if (dataState is DataSuccess) {
          LoginModel model = dataState.data;
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.accessKey, model.access));
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.refreshKey, model.refresh));
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.phoneKey, model.phoneNumber));

          emit(state.copyWith(newLoginStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(newLoginStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newLoginStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(newRegisterStatus: BaseLoading()));
      try {
        DataState dataState = await registerUseCase(
            LoginParams(event.number, event.password, event.otp));
        if (dataState is DataSuccess) {
          LoginModel model = dataState.data;
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.accessKey, model.access));
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.refreshKey, model.refresh));
          await writeLocalStorageUseCase(
              WriteLocalStorageParam(Constants.phoneKey, model.phoneNumber));
          emit(state.copyWith(newRegisterStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(newRegisterStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newRegisterStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(state.copyWith(newResetPasswordStatus: BaseLoading()));
      try {
        DataState dataState = await resetPasswordUseCase(
            LoginParams(event.number, event.password, event.otp));
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newResetPasswordStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newResetPasswordStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newResetPasswordStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendPhoneStatus: BaseNoAction()));
    });
    on<RegisterVerifyEvent>((event, emit) async {
      emit(state.copyWith(newRegisterVerifyStatus: BaseLoading()));
      try {
        DataState dataState = await registerVerifyUseCase(
            RegisterVerifyParams(event.number, event.otp));
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newRegisterVerifyStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newRegisterVerifyStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newRegisterVerifyStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newRegisterVerifyStatus: BaseNoAction()));
    });

    on<SendLoginOtpEvent>((event, emit) async {
      emit(state.copyWith(newSendLoginOtpStatus: BaseLoading()));
      try {
        DataState dataState = await sendLoginOtpUseCase(event.number);
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSendLoginOtpStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newSendLoginOtpStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newSendLoginOtpStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendLoginOtpStatus: BaseNoAction()));
    });

    on<SendResetOtpEvent>((event, emit) async {
      emit(state.copyWith(newSendResetOtpStatus: BaseLoading()));
      try {
        DataState dataState = await sendLoginOtpUseCase(event.number);
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSendResetOtpStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newSendResetOtpStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newSendResetOtpStatus: BaseError(e.toString())));
      }
      emit(state.copyWith(newSendResetOtpStatus: BaseNoAction()));
    });
    on<ChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(newChangePasswordStatus: BaseLoading()));
      try {
        DataState dataState = await changePasswordUseCase(
            ChangePasswordParams(event.oldPassword, event.newPassword));
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newChangePasswordStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newChangePasswordStatus: BaseError(dataState.error)));
        }
      } catch (e) {
        emit(state.copyWith(newChangePasswordStatus: BaseError(e.toString())));
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
      emit(state.copyWith(newLogOutStatus: BaseSuccess(null)));
      emit(state.copyWith(newLogOutStatus: BaseNoAction()));
    });
  }
}
