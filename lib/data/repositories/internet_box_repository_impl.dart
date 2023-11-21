import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class InternetBoxRepositoryImpl extends InternetBoxRepository {
  @override
  Future<DataState<InternetBoxModel>> createInternetBox(
      CreateGroupParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "internetbox/",
        data: {
          "name": params.name,
          "description": params.description,
        },
      );
      if (response.statusCode == 201) {
        return DataSuccess(InternetBoxModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> deleteInternetBox(int params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "internetbox/{${params.toString()}}",
        method: "DELETE",
      );
      if (response.statusCode == 204) {
        return DataSuccess(response.data.toString());
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InternetBoxModel>> getInternetBoxById(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
          "internetbox/{${id.toString()}}",
          method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess(InternetBoxModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<List<InternetBoxModel>>> getInternetBoxList() async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("internetbox/", method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess(List<InternetBoxModel>.from(
            response.data.map((model) => InternetBoxModel.fromJson(model))));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InternetBoxModel>> updateInternetBox(
      UpdateGroupParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("internetbox/${params.id.toString()}",
              data: {
                "name": params.name,
                "description": params.description,
              },
              method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess(InternetBoxModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InternetBoxModel>> updateInternetBoxOwner(
      UpdateGroupOwnerParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest("${params.uuid}/",
          data: {
            "name": params.name,
            "description": params.description,
          },
          method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess(InternetBoxModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<InternetBoxModel>> editInternetBoxName(
      EditGroupNameParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
          "internetbox/${params.id.toString()}/",
          data: {
            "name": params.name,
          },
          method: 'PATCH');
      if (response.statusCode == 200) {
        return DataSuccess(InternetBoxModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
