part of 'auth_bloc.dart';

class AuthState {
  BaseStatus sendPhoneStatus,
      loginStatus,
      registerStatus,
      resetPasswordStatus,
      registerVerifyStatus,
      sendLoginOtpStatus,
      changePasswordStatus,
      logOutStatus,
      sendResetOtpStatus;
  ConnectionType connectionType;
  LanguageType languageType;

  AuthState({
    required this.loginStatus,
    required this.registerStatus,
    required this.resetPasswordStatus,
    required this.sendPhoneStatus,
    required this.registerVerifyStatus,
    required this.sendLoginOtpStatus,
    required this.changePasswordStatus,
    required this.sendResetOtpStatus,
    required this.logOutStatus,
    required this.connectionType,
    required this.languageType,
  });

  AuthState copyWith({
    BaseStatus? newSendPhoneStatus,
    newLoginStatus,
    newRegisterStatus,
    newResetPasswordStatus,
    newRegisterVerifyStatus,
    newSendLoginOtpStatus,
    newSendResetOtpStatus,
    newChangePasswordStatus,
    newLogOutStatus,
    ConnectionType? newConnectionType,
    LanguageType? newLanguageType,
  }) {
    return AuthState(
      loginStatus: newLoginStatus ?? loginStatus,
      registerStatus: newRegisterStatus ?? registerStatus,
      sendPhoneStatus: newSendPhoneStatus ?? sendPhoneStatus,
      resetPasswordStatus: newResetPasswordStatus ?? registerStatus,
      registerVerifyStatus: newRegisterVerifyStatus ?? registerStatus,
      sendLoginOtpStatus: newSendLoginOtpStatus ?? sendLoginOtpStatus,
      sendResetOtpStatus: newSendResetOtpStatus ?? sendResetOtpStatus,
      changePasswordStatus: newChangePasswordStatus ?? changePasswordStatus,
      logOutStatus: newLogOutStatus ?? logOutStatus,
      connectionType: newConnectionType ?? connectionType,
      languageType: newLanguageType ?? languageType,
    );
  }
}
