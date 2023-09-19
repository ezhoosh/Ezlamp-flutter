part of 'auth_bloc.dart';

class AuthState {
  BaseStatus sendPhoneStatus,
      loginStatus,
      registerStatus,
      resetPasswordStatus,
      registerVerifyStatus;
  AuthState({
    required this.loginStatus,
    required this.registerStatus,
    required this.resetPasswordStatus,
    required this.sendPhoneStatus,
    required this.registerVerifyStatus,
  });

  AuthState copyWith({
    BaseStatus? newSendPhoneStatus,
    BaseStatus? newLoginStatus,
    BaseStatus? newRegisterStatus,
    BaseStatus? newResetPasswordStatus,
    BaseStatus? newRegisterVerifyStatus,
  }) {
    return AuthState(
        loginStatus: newLoginStatus ?? loginStatus,
        registerStatus: newRegisterStatus ?? registerStatus,
        sendPhoneStatus: newSendPhoneStatus ?? sendPhoneStatus,
        resetPasswordStatus: newResetPasswordStatus ?? registerStatus,
        registerVerifyStatus: newRegisterStatus ?? registerStatus);
  }
}
