import 'package:dio/dio.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  @override
  Future<DataState<RefreshTokenModel>> refreshToken(String params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "auth/token/refresh/",
        data: {"refresh": params},
      );
      if (response.statusCode == 200) {
        return DataSuccess<RefreshTokenModel>(
            RefreshTokenModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
