import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/schudule_model.dart';

abstract class ScheduleRepository {
  Future<DataState<List<ScheduleModel>>> getScheduleList();

  Future<DataState<ScheduleModel>> getScheduleById(int id);

  Future<DataState<ScheduleModel>> createSchedule(CreateScheduleParams params);

  Future<DataState<ScheduleModel>> putSchedule(UpdateScheduleParams params);

  Future<DataState<ScheduleModel>> patchSchedule(UpdateScheduleParams params);

  Future<DataState<String>> deleteSchedule(int id);
}
