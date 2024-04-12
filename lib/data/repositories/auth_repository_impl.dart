import 'package:dio/dio.dart';
import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository   {
  AuthRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<SendNumberModel>> sendPhoneNumber(
      SendPhoneNumberParams params) async {
    try {
      var response = await httpClient.postRequest(path:
        "auth/is-user-exists/",
        data: {"phone_number": params.number},
      );
      // if (response.statusCode == 200) {
        return DataSuccess<SendNumberModel>(
            SendNumberModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<LoginModel>> login(LoginParams params) async {
    try {
      var response =
          await httpClient.postRequest(path: "auth/login/", data: params.toJson());
      // if (response.statusCode == 200) {
        return DataSuccess<LoginModel>(LoginModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<LoginModel>> register(LoginParams params) async {
    try {
      var response =
          await httpClient.postRequest(path: "auth/register/", data: {
        "phone_number": params.number,
        "password": params.password,
        "sms_token": params.smsToken,
      });
      // if (response.statusCode == 200) {
        return DataSuccess<LoginModel>(LoginModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<ResetPasswordModel>> resetPassword(
      LoginParams params) async {
    try {
      var response = await httpClient.postRequest(path:
          "auth/reset-password/",
          data: {
            "phone_number": params.number,
            "password": params.password,
            // "sms_token": params.smsToken,
          });
      // if (response.statusCode == 200) {
        return DataSuccess<ResetPasswordModel>(
            ResetPasswordModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<RegisterVerifyModel>> registerVerify(
      RegisterVerifyParams params) async {
    try {
      var response = await httpClient.postRequest(path:
          "auth/verify-register-otp/",
          data: {
            "phone_number": params.phone,
            "token": params.otp,
          });
      // if (response.statusCode == 200) {
        return DataSuccess<RegisterVerifyModel>(
            RegisterVerifyModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<SendLoginOtpModel>> sendLoginOtp(String params) async {
    try {
      var response = await httpClient.postRequest(path:
          "auth/send-login-otp/",
          data: {
            "phone_number": params,
          });
      // if (response.statusCode == 200) {
        return DataSuccess<SendLoginOtpModel>(
            SendLoginOtpModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> changePassword(ChangePasswordParams params) async {
    try {
      var response = await httpClient.postRequest(path:
        "auth/change-password/",
        data: {
          "old_password": params.oldPassword,
          "new_password": params.newPassword,
        },
      );
      // if (response.statusCode == 200) {
        return DataSuccess(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
