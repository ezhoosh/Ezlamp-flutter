part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SendPhoneNumberEvent extends AuthEvent {
  String number;

  SendPhoneNumberEvent(this.number);
}

class LoginEvent extends AuthEvent {
  String number;
  String otp;
  String password;

  LoginEvent(this.number, this.otp, this.password);
}

class RegisterEvent extends AuthEvent {
  String number;
  String otp;
  String password;

  RegisterEvent(this.number, this.otp, this.password);
}

class ResetPasswordEvent extends AuthEvent {
  String number;
  String otp;
  String password;

  ResetPasswordEvent(this.number, this.otp, this.password);
}
