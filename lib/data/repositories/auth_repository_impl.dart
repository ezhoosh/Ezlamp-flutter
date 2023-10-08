import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<DataState<SendNumberModel>> sendPhoneNumber(
      SendPhoneNumberParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequestWithoutAuth(
        "auth/is-user-exists/",
        data: {"phone_number": params.number},
      );
      if (response.statusCode == 200) {
        return DataSuccess<SendNumberModel>(
            SendNumberModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<LoginModel>> login(LoginParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequestWithoutAuth("auth/login/", data: {
        "phone_number": params.number,
        "password": params.password,
        "sms_token": params.smsToken,
      });
      if (response.statusCode == 200) {
        return DataSuccess<LoginModel>(LoginModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<LoginModel>> register(LoginParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequestWithoutAuth("auth/register/", data: {
        "phone_number": params.number,
        "password": params.password,
        "sms_token": params.smsToken,
      });
      if (response.statusCode == 200) {
        return DataSuccess<LoginModel>(LoginModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<ResetPasswordModel>> resetPassword(
      LoginParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequestWithoutAuth(
          "auth/reset-password/",
          data: {
            "phone_number": params.number,
            "password": params.password,
            "sms_token": params.smsToken,
          });
      if (response.statusCode == 200) {
        return DataSuccess<ResetPasswordModel>(
            ResetPasswordModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<RegisterVerifyModel>> registerVerify(
      RegisterVerifyParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequestWithoutAuth(
          "auth/verify-register-otp/",
          data: {
            "phone_number": params.phone,
            "token": params.otp,
          });
      if (response.statusCode == 200) {
        return DataSuccess<RegisterVerifyModel>(
            RegisterVerifyModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<SendLoginOtpModel>> sendLoginOtp(String params) async {
    try {
      var response = await ApiAccess.makeHttpRequestWithoutAuth(
          "auth/send-login-otp/",
          data: {
            "phone_number": params,
          });
      if (response.statusCode == 200) {
        return DataSuccess<SendLoginOtpModel>(
            SendLoginOtpModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<String>> changePassword(ChangePasswordParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "auth/change-password/",
        data: {
          "old_password": params.oldPassword,
          "new_password": params.newPassword,
        },
      );
      if (response.statusCode == 200) {
        return DataSuccess(response.data.toString());
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
