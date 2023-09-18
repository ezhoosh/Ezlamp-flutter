import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
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

  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
    this.resetPasswordUseCase,
    this.sendPhoneNumberUseCase,
    this.writeLocalStorageUseCase,
    this.readLocalStorageUseCase,
  ) : super(AuthState(
            loginStatus: BaseNoAction(),
            registerStatus: BaseNoAction(),
            resetPasswordStatus: BaseNoAction(),
            sendPhoneStatus: BaseNoAction())) {
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
          LoginModel model=dataState.data;
          await writeLocalStorageUseCase(WriteLocalStorageParam(Constants.accessKey, model.access));
          await writeLocalStorageUseCase(WriteLocalStorageParam(Constants.refreshKey, model.refresh));
          await writeLocalStorageUseCase(WriteLocalStorageParam(Constants.phoneKey, model.phoneNumber));

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
  }
}
