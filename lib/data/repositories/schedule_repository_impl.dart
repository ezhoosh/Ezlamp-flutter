import 'package:dio/dio.dart';
import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/api_access.dart';
import 'package:easy_lamp/data/model/schudule_model.dart';
import 'package:easy_lamp/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<DataState<ScheduleModel>> createSchedule(
      CreateScheduleParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest("schedule/",
          method: "POST", data: params.toJson());
      if (response.statusCode == 201) {
        return DataSuccess(ScheduleModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<String>> deleteSchedule(int id) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("schedule/$id/", method: "DELETE");
      if (response.statusCode == 204) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<ScheduleModel>> getScheduleById(int id) async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("schedule/$id/", method: "GET");
      if (response.statusCode == 200) {
        return DataSuccess(ScheduleModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<ScheduleModel>>> getScheduleList() async {
    try {
      var response =
          await ApiAccess.makeHttpRequest("schedule/", method: "GET");
      if (response.statusCode == 200) {
        return DataSuccess(List<ScheduleModel>.from(
            response.data.map((model) => ScheduleModel.fromJson(model))));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<ScheduleModel>> patchSchedule(
      UpdateScheduleParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest("schedule/${params.id}/",
          data: params.toJson(), method: "PATCH");
      if (response.statusCode == 200) {
        return DataSuccess(ScheduleModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<ScheduleModel>> putSchedule(
      UpdateScheduleParams params) async {
    try {
      var response = await ApiAccess.makeHttpRequest("schedule/${params.id}/",
          data: params.toJson(), method: "PUT");
      if (response.statusCode == 200) {
        return DataSuccess(ScheduleModel.fromJson(response.data));
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
