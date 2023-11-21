import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/core/utils/normalize.dart';
import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/domain/repositories/command_repository.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';

class CommandRepositoryImpl extends CommandRepository {
  @override
  Future<DataState<CommandModel>> sendCommand(CommandParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "mqtt/lamp-command/",
        data: {
          "w": params.w,
          "y": params.y,
          "r": (Normalize.normalizeValue(params.r) / 100) * params.s,
          "g": (Normalize.normalizeValue(params.g) / 100) * params.s,
          "b": (Normalize.normalizeValue(params.b) / 100) * params.s,
          "c": params.c,
          "pir": true,
          "type": "apply",
          if (params.lamps != null) "lamps": params.lamps,
          if (params.gid != null) "gid": params.gid.toString(),
        },
      );
      if (response.statusCode == 200) {
        return DataSuccess(CommandModel.fromJson(response.data));
      } else {
        return DataFailed(ErrorHelper.getError(response));
      }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
