import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';

class LampRepositoryImpl extends LampRepository {
  @override
  Future<DataState<String>> deleteLamp(int params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "lamps/${params.toString()}/",
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
  Future<DataState<LampModel>> getLampById(int id) async {
    try {
      var response = await ApiAccess.makeHttpRequest("lamps/${id.toString()}/",
          method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess<LampModel>(LampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<LampModel>> updateLampOwner(
      UpdateLampOwnerParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("${params.uuid.toString()}/",
              data: {
                "name": params.name,
                "description": params.description,
                "is_active": true,
                "latitude": "008",
                "longitude": "-02",
                "address": "string",
                "group_lamp": params.groupLamp.toString(),
                "main_power": "string",
                "last_command": {
                  "additionalProp1": "string",
                  "additionalProp2": "string",
                  "additionalProp3": "string"
                },
                if (params.internetBox != null)
                  "internet_box": params.internetBox.toString()
              },
              method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess<LampModel>(LampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<LampModel>>> getLampList(
      GetLampListParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
          "group-lamp/${params.groupId.toString()}/",
          method: 'GET');
      if (response.statusCode == 200) {
        return DataSuccess<List<LampModel>>(
            GroupModel.fromJson(response.data).lamps);
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<LampModel>> updateLampById(params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("lamps/${params.lampId.toString()}",
              data: {
                "name": params.name,
                "description": params.description,
                "is_active": params.isActive.toString(),
                "latitude": params.latitude,
                "longitude": params.longitude,
                "address": params.address,
                "group_lamp": params.groupLamp.toString(),
                "main_power": params.mainPower,
                "last_command": params.lastCommand,
              },
              method: 'PUT');
      if (response.statusCode == 200) {
        return DataSuccess<LampModel>(LampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<LampModel>> patchLampById(PatchLampListParams params) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("lamps/${params.lampId.toString()}/",
              data: {
                if (params.name != null) "name": params.name,
                if (params.description != null)
                  "description": params.description,
                if (params.isActive != null)
                  "is_active": params.isActive.toString(),
                if (params.latitude != null) "latitude": params.latitude,
                if (params.longitude != null) "longitude": params.longitude,
                if (params.address != null) "address": params.address,
                if (params.groupLamp != null)
                  "group_lamp": params.groupLamp.toString(),
                if (params.mainPower != null) "main_power": params.mainPower,
                if (params.lastCommand != null)
                  "last_command": params.lastCommand,
              },
              method: 'PATCH');
      if (response.statusCode == 200) {
        return DataSuccess<LampModel>(LampModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
