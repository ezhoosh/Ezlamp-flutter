import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/user_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<DataState<UserModel>> getUser() async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "auth/user/me",
        method: "GET",
      );
      if (response.statusCode == 200) {
        return DataSuccess(UserModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<UserModel>> updateUser(UserParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("auth/user/", method: "PUT", data: {
        'first_name': params.firstName,
        'last_name': params.lastName,
        'email': params.email
      });
      if (response.statusCode == 200) {
        return DataSuccess(UserModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
