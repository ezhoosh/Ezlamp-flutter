import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/domain/usecases/login_usecase.dart';
import 'package:easy_lamp/domain/usecases/register_usecase.dart';
import 'package:easy_lamp/domain/usecases/reset_password_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_phone_number_usecase.dart';
import 'package:meta/meta.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUseCase loginUseCase;
  RegisterUseCase registerUseCase;
  ResetPasswordUseCase resetPasswordUseCase;
  SendPhoneNumberUseCase sendPhoneNumberUseCase;

  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
    this.resetPasswordUseCase,
    this.sendPhoneNumberUseCase,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
  }
}
