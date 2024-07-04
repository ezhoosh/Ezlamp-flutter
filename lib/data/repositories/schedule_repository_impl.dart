import 'package:easy_lamp/core/network/i_api_request_manager.dart';
import 'package:easy_lamp/core/repository/base_repository.dart';
import 'package:easy_lamp/core/widgets/error_helper.dart';
import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/schudule_model.dart';
import 'package:easy_lamp/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends BaseRepository implements ScheduleRepository {
  ScheduleRepositoryImpl(IHttpClient httpClient) : super(httpClient);

  @override
  Future<DataState<ScheduleModel>> createSchedule(
      CreateScheduleParams params) async {
    try {
      var response = await httpClient.postRequest(path:"schedule/", data: params.toJson());
      // if (response.statusCode == 201) {
        return DataSuccess(ScheduleModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<String>> deleteSchedule(int id) async {
    try {
      var response =
          await httpClient.deleteRequest(path:"schedule/$id/",);
      // if (response.statusCode == 204) {
        return DataSuccess(response);
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<ScheduleModel>> getScheduleById(int id) async {
    try {
      var response =
          await httpClient.getRequest(path:"schedule/$id/");
      // if (response.statusCode == 200) {
        return DataSuccess(ScheduleModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<List<ScheduleModel>>> getScheduleList() async {
    try {
      var response =
          await httpClient.getRequest(path:"schedule/");
      // if (response.statusCode == 200) {
        return DataSuccess(List<ScheduleModel>.from(
            response.map((model) => ScheduleModel.fromJson(model))));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<ScheduleModel>> patchSchedule(
      UpdateScheduleParams params) async {
    try {
      var response = await httpClient.patchRequest(path:"schedule/${params.id}/",
          data: params.toJson());
      // if (response.statusCode == 200) {
        return DataSuccess(ScheduleModel.fromJson(response));
      // } else {
      //   return DataFailed(ErrorHelper.getError(response));
      // }
    } on DioError catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }

  @override
  Future<DataState<ScheduleModel>> putSchedule(
      UpdateScheduleParams params) async {
    try {
      var response = await httpClient.putRequest(path:"schedule/${params.id}/",
          data: params.toJson());
      // if (response.statusCode == 200) {
        var result =  DataSuccess(ScheduleModel.fromJson(response));
        return result;
      // } else {
      //   return DataFailed(response.statusMessage.toString());
      // }
    } on DioException catch (e) {
      return DataFailed(ErrorHelper.getCatchError(e));
    }
  }
}
