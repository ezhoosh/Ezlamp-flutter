part of 'auth_bloc.dart';

class AuthState {
  BaseStatus sendPhoneStatus,
      loginStatus,
      registerStatus,
      resetPasswordStatus,
      registerVerifyStatus,
      sendLoginOtpStatus,
      sendResetOtpStatus;
  AuthState({
    required this.loginStatus,
    required this.registerStatus,
    required this.resetPasswordStatus,
    required this.sendPhoneStatus,
    required this.registerVerifyStatus,
    required this.sendLoginOtpStatus,
    required this.sendResetOtpStatus,
  });

  AuthState copyWith({
    BaseStatus? newSendPhoneStatus,
    newLoginStatus,
    newRegisterStatus,
    newResetPasswordStatus,
    newRegisterVerifyStatus,
    newSendLoginOtpStatus,
    newSendResetOtpStatus,
  }) {
    return AuthState(
      loginStatus: newLoginStatus ?? loginStatus,
      registerStatus: newRegisterStatus ?? registerStatus,
      sendPhoneStatus: newSendPhoneStatus ?? sendPhoneStatus,
      resetPasswordStatus: newResetPasswordStatus ?? registerStatus,
      registerVerifyStatus: newRegisterVerifyStatus ?? registerStatus,
      sendLoginOtpStatus: newSendLoginOtpStatus ?? sendLoginOtpStatus,
      sendResetOtpStatus: newSendResetOtpStatus ?? sendResetOtpStatus,
    );
  }
}
