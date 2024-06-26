import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends  BaseRepository implements GroupRepository {
  GroupRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<GroupModel>> createGroup(
      CreateGroupParams params) async {
    try {
      var response = await httpClient.postRequest(path:
        "group-lamp/",
        data: {
          "name": params.name,
          "description": params.description,
        },
      );
      // if (response.statusCode == 201) {
        return DataSuccess<GroupModel>(
            GroupModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> deleteGroup(int params) async {
    try {
      var response = await httpClient.deleteRequest(path:
        "group-lamp/${params.toString()}/"
      );
      // if (response.statusCode == 204) {
        return DataSuccess<String>(response.toString());
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<GroupModel>> getGroupById(int id) async {
    try {
      var response = await httpClient.getRequest(path:
          "group-lamp/{${id.toString()}}");
      // if (response.statusCode == 200) {
        return DataSuccess<GroupModel>(
            GroupModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<List<GroupModel>>> getGroupList() async {
    try {
      var response =
          await httpClient.getRequest(path: "group-lamp/");
      // if (response.statusCode == 200) {
        return DataSuccess(List<GroupModel>.from(
            response.map((model) => GroupModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<GroupModel>> updateGroup(
      UpdateGroupParams params) async {
    try {
      var response =
          await httpClient.putRequest(path: "group-lamp/${params.id.toString()}",
              data: {
                "name": params.name,
                "description": params.description,
              });
      // if (response.statusCode == 200) {
        return DataSuccess<GroupModel>(
            GroupModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<GroupModel>> updateGroupOwner(
      UpdateGroupOwnerParams params) async {
    try {
      // "group-lamp/update-group-owner/${params.uuid.toString()}",
      var response =
          await httpClient.putRequest(path:"${params.uuid.toString()}/",
              data: {
                "name": params.name,
                "description": params.description,
              }, );
      // if (response.statusCode == 200) {
        return DataSuccess<GroupModel>(
            GroupModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<GroupModel>> editGroupName(
      EditGroupNameParams params) async {
    try {
      var response =
          await httpClient.patchRequest(path: "group-lamp/${params.id.toString()}/",
              data: {
                "name": params.name,
              },);
      // if (response.statusCode == 200) {
        return DataSuccess<GroupModel>(
            GroupModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
