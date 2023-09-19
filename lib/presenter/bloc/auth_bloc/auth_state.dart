part of 'auth_bloc.dart';

class AuthState {
  BaseStatus sendPhoneStatus,
      loginStatus,
      registerStatus,
      resetPasswordStatus,
      registerVerifyStatus,
      sendLoginOtpStatus;
  AuthState({
    required this.loginStatus,
    required this.registerStatus,
    required this.resetPasswordStatus,
    required this.sendPhoneStatus,
    required this.registerVerifyStatus,
    required this.sendLoginOtpStatus,
  });

  AuthState copyWith({
    BaseStatus? newSendPhoneStatus,
    newLoginStatus,
    newRegisterStatus,
    newResetPasswordStatus,
    newRegisterVerifyStatus,
    newSendLoginOtpStatus,
  }) {
    return AuthState(
      loginStatus: newLoginStatus ?? loginStatus,
      registerStatus: newRegisterStatus ?? registerStatus,
      sendPhoneStatus: newSendPhoneStatus ?? sendPhoneStatus,
      resetPasswordStatus: newResetPasswordStatus ?? registerStatus,
      registerVerifyStatus: newRegisterStatus ?? registerStatus,
      sendLoginOtpStatus: newSendLoginOtpStatus ?? sendLoginOtpStatus,
    );
  }
}
