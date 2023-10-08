import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/domain/repositories/command_repository.dart';

class CommandRepositoryImpl extends CommandRepository {
  @override
  Future<DataState<CommandModel>> sendCommand(CommandParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "mqtt/lamp-command/",
        data: {},
      );
      if (response.statusCode == 200) {
        return DataSuccess(CommandModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
