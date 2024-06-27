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

class RegisterVerifyEvent extends AuthEvent {
  String number;
  String otp;

  RegisterVerifyEvent(this.number, this.otp);
}

class ResetPasswordEvent extends AuthEvent {
  String number;
  String otp;
  String password;

  ResetPasswordEvent(this.number, this.otp, this.password);
}
class PostResetPasswordEvent extends AuthEvent {
  String number;
  String password;

  PostResetPasswordEvent(this.number, this.password);
}
class ResetPasswordOtpEvent extends AuthEvent {
  String number;
  String otp;

  ResetPasswordOtpEvent(this.number, this.otp);
}

class SendLoginOtpEvent extends AuthEvent {
  String number;

  SendLoginOtpEvent(this.number);
}

class SendResetOtpEvent extends AuthEvent {
  String number;

  SendResetOtpEvent(this.number);
}

class ChangePasswordEvent extends AuthEvent {
  String oldPassword;
  String newPassword;

  ChangePasswordEvent(this.oldPassword, this.newPassword);
}

class ChangeConnectionTypeEvent extends AuthEvent {
  ConnectionType type;

  ChangeConnectionTypeEvent(this.type);
}

class ChangeLanguageTypeEvent extends AuthEvent {
  LanguageType type;

  ChangeLanguageTypeEvent(this.type);
}

class GetConnectionTypeEvent extends AuthEvent {}

class GetLanguageTypeEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class GetVersionAuthEvent extends AuthEvent {}
