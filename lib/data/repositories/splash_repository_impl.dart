import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/refresh_token_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  @override
  Future<DataState<RefreshTokenModel>> refreshToken(String params) async {
    var response = await ApiAccess.makeHttpRequest(
      "auth/token/refresh/",
      data: {"refresh": params},
    );
    if (response.statusCode == 200) {
      return DataSuccess<RefreshTokenModel>(
          RefreshTokenModel.fromJson(response.data));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }
}
