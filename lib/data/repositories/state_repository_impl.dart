import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/domain/repositories/state_repository.dart';
import 'package:flutter/cupertino.dart';

class StateRepositoryImpl extends StateRepository {
  @override
  Future<DataState<List<StateModel>>> getDataState(StateParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest(
        "state/",
        method: "GET",
        data: {
          if (params.groupLampId != null) "group_lamp_id": params.groupLampId,
          if (params.isLampOn != null) "is_lamps_on": params.isLampOn,
          if (params.timeStamp != null) "timestamp": params.timeStamp,
          if (params.timeStampGte != null)
            "timestamp__gte": params.timeStampGte,
          if (params.timeStampLte != null)
            "timestamp__lte": params.timeStampLte,
        },
      );
      if (response.statusCode == 200) {
        return DataSuccess(List<StateModel>.from(
            response.data.map((model) => StateModel.fromJson(model))));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}