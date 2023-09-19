import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';

abstract class SplashRepository {
  Future<DataState<RefreshTokenModel>> refreshToken(
      String params);
}
