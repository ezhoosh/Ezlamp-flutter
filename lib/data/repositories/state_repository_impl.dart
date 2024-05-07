import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/domain/repositories/state_repository.dart';

class StateRepositoryImpl extends BaseRepository implements StateRepository {
  StateRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<List<StateModel>>> getDataState(StateParams params) async {
    try {
      var response = await httpClient.getRequest(path:
        "state/",
        queryParameters: {
          'which_param': params.whichParam,
          if (params.groupLampId != null) "group_lamp_id": params.groupLampId,
          if (params.isLampOn != null) "is_lamps_on": params.isLampOn,
          if (params.timeStamp != null) "timestamp": params.timeStamp,
          if (params.timeStampGte != null)
            "timestamp__gte": params.timeStampGte!.toString(),
          if (params.timeStampLte != null)
            "timestamp__lte": params.timeStampLte!.toString(),
          if (params.lamps != null) "lamps": params.lamps,
        },
      );
      print('state data: ${jsonEncode(response)}');
      // if (response.statusCode == 200) {
        return DataSuccess(List<StateModel>.from(
            response.map((model) => StateModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
  @override
  Future<DataState<List<StateModel>>> getDataStateInternet(StateParams params) async {
    try {
      var response = await httpClient.getRequest(path:
        "https://ezlamp.darkube.app//api/v1/state//internetbox/",
        queryParameters: {
          'which_param': params.whichParam,
          if (params.lamps != null) "internetboxes": params.lamps,
          if (params.timeStampGte != null)
            "timestamp__gte": params.timeStampGte!.toString(),
          if (params.timeStampLte != null)
            "timestamp__lte": params.timeStampLte!.toString(),
        },
      );
      print('state data: ${jsonEncode(response)}');
      // if (response.statusCode == 200) {
        return DataSuccess(List<StateModel>.from(
            response.map((model) => StateModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
