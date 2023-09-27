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
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
  @override
  Future<DataState<GroupLampModel>> createGroup(
      CreateGroupParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "group-lamp/",
        data: {
          "name": params.name,
          "description": params.description,
        },
      );
      if (response.statusCode == 201) {
        return DataSuccess<GroupLampModel>(
            GroupLampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<String>> deleteGroup(int params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "group-lamp/{${params.toString()}}",
        method: "DELETE",
      );
      if (response.statusCode == 204) {
        return DataSuccess<String>(response.data.toString());
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<GroupLampModel>> getGroupById(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
          "group-lamp/{${id.toString()}}",
          method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess<GroupLampModel>(
            GroupLampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<GroupLampModel>>> getGroupList() async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("group-lamp/", method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess(List<GroupLampModel>.from(
            response.data.map((model) => GroupLampModel.fromJson(model))));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<GroupLampModel>> updateGroup(
      UpdateGroupParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("group-lamp/${params.id.toString()}",
              data: {
                "name": params.name,
                "description": params.description,
              },
              method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess<GroupLampModel>(
            GroupLampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<GroupLampModel>> updateGroupOwner(
      UpdateGroupOwnerParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
          "group-lamp/update-group-owner/${params.uuid.toString()}",
          data: {
            "name": params.name,
            "description": params.description,
          },
          method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess<GroupLampModel>(
            GroupLampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<GroupLampModel>> editGroupName(
      EditGroupNameParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("group-lamp/${params.id.toString()}/",
              data: {
                "name": params.name,
              },
              method: 'PATCH');
      if (response.statusCode == 200) {
        return DataSuccess<GroupLampModel>(
            GroupLampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
