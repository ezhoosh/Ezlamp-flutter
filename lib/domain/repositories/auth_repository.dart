import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';

abstract class AuthRepository {
  Future<DataState<SendNumberModel>> sendPhoneNumber(
      SendPhoneNumberParams params);

  Future<DataState<LoginModel>> login(LoginParams params);

  Future<DataState<LoginModel>> register(LoginParams params);

  Future<DataState<ResetPasswordModel>> resetPassword(LoginParams params);
  Future<DataState<RegisterVerifyModel>> registerVerify(
      RegisterVerifyParams params);
}
