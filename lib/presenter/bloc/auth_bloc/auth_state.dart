part of 'auth_bloc.dart';

class AuthState {
  BaseStatus sendPhoneStatus;
  BaseStatus loginStatus;
  BaseStatus registerStatus;
  BaseStatus resetPasswordStatus;
  AuthState({
    required this.loginStatus,
    required this.registerStatus,
    required this.resetPasswordStatus,
    required this.sendPhoneStatus,
  });

  AuthState copyWith({
    BaseStatus? newSendPhoneStatus,
    BaseStatus? newLoginStatus,
    BaseStatus? newRegisterStatus,
    BaseStatus? newResetPasswordStatus,
  }) {
    return AuthState(
        loginStatus: newLoginStatus ?? loginStatus,
        registerStatus: newRegisterStatus ?? registerStatus,
        sendPhoneStatus: newSendPhoneStatus ?? sendPhoneStatus,
        resetPasswordStatus: newResetPasswordStatus ?? registerStatus);
  }
}
