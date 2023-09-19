part of 'splash_bloc.dart';

class SplashState {
  BaseStatus checkLoginStatus, refreshTokenStatus;
  SplashState(
      {required this.checkLoginStatus, required this.refreshTokenStatus});
  SplashState copyWith(
      {BaseStatus? newCheckLoginStatus, newRefreshTokenStatus}) {
    return SplashState(
      checkLoginStatus: newCheckLoginStatus ?? checkLoginStatus,
      refreshTokenStatus: newRefreshTokenStatus ?? refreshTokenStatus,
    );
  }
}
