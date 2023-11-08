part of 'splash_bloc.dart';

class SplashState {
  SplashStatus checkLoginStatus;
  BaseStatus refreshTokenStatus;

  SplashState(
      {required this.checkLoginStatus, required this.refreshTokenStatus});

  SplashState copyWith({
    BaseStatus? newRefreshTokenStatus,
    SplashStatus? newCheckLoginStatus,
  }) {
    return SplashState(
      checkLoginStatus: newCheckLoginStatus ?? checkLoginStatus,
      refreshTokenStatus: newRefreshTokenStatus ?? refreshTokenStatus,
    );
  }
}
