import 'package:dio/dio.dart';
import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends BaseRepository implements SplashRepository {
  SplashRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<RefreshTokenModel>> refreshToken(String params) async {
    try {
      var response = await httpClient.postRequest(path:
        "auth/token/refresh/",
        data: {"refresh": params},
      );
      // if (response.statusCode == 200) {
        return DataSuccess<RefreshTokenModel>(
            RefreshTokenModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
