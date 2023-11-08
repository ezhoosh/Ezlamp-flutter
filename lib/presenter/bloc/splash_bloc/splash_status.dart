abstract class SplashStatus {}

class SplashSuccessWithBlue extends SplashStatus {
  bool entity;

  SplashSuccessWithBlue(this.entity);
}

class SplashSuccessWithOutBlue extends SplashStatus {
  bool entity;

  SplashSuccessWithOutBlue(this.entity);
}

class SplashNoAction extends SplashStatus {}

class SplashLoading extends SplashStatus {}

class SplashError extends SplashStatus {
  String? error;

  SplashError(this.error);
}
