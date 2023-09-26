import 'dart:convert';

import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/params/update_lamps_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/Lamp_repository.dart';

class LampRepositoryImpl extends LampRepository {
  @override
  Future<DataState<String>> deleteLamp(int params) async {
    var response = await ApiAccess.makeHttpRequest(
      "lamps/{${params.toString()}}",
      method: "DELETE",
    );
    if (response.statusCode == 204) {
      return DataSuccess<String>(response.data.toString());
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<LampModel>> getLampById(int id) async {
    var response = await ApiAccess.makeHttpRequest("lamps/{${id.toString()}}",
        method: 'GET');
    if (response.statusCode == 200) {
      return DataSuccess<LampModel>(LampModel.fromJson(response.data));
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<List<LampModel>>> getLampList(GetLampsParams params) async {
    var response = await ApiAccess.makeHttpRequest("lamps/", method: 'GET');
    if (response.statusCode == 200) {
      return DataSuccess<List<LampModel>>(json
          .decode(response.data)
          .map((data) => LampModel.fromJson(data))
          .toList());
    } else {
      return DataFailed(response.statusMessage.toString());
    }
  }

  @override
  Future<DataState<LampModel>> updateLampById(UpdateLampsParams params) async {
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
  }

  @override
  Future<DataState<LampModel>> updateLampOwner(
      UpdateLampOwnerParams params) async {
    var response = await ApiAccess.makeHttpRequest(
        "lamps/update-lamp-owner/${params.uuid.toString()}",
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
  }
}
