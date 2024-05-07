import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/core/params/update_schedule_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/usecases/create_schedule_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_schedule_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_schedule_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_schedule_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/patch_schedule_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/put_schedule_by_id_usecase.dart';
import 'package:meta/meta.dart';

part 'schedule_event.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  CreateScheduleUseCase createScheduleListUseCase;
  PutScheduleByIdUseCase putScheduleByIdUseCase;
  PatchScheduleByIdUseCase patchScheduleByIdUseCase;
  DeleteScheduleByIdUseCase deleteScheduleByIdUseCase;
  GetScheduleByIdUseCase getScheduleByIdUseCase;
  GetScheduleListUseCase getScheduleListUseCase;

  ScheduleBloc(
      this.createScheduleListUseCase,
      this.putScheduleByIdUseCase,
      this.patchScheduleByIdUseCase,
      this.deleteScheduleByIdUseCase,
      this.getScheduleByIdUseCase,
      this.getScheduleListUseCase)
      : super(
          ScheduleState(
            createScheduleListStatus: BaseNoAction(),
            putScheduleByIdStatus: BaseNoAction(),
            patchScheduleByIdStatus: BaseNoAction(),
            deleteScheduleByIdStatus: BaseNoAction(),
            getScheduleByIdStatus: BaseNoAction(),
            getScheduleListStatus: BaseNoAction(),
          ),
        ) {
    on<CreateScheduleEvent>((event, emit) async {
      emit(state.copyWith(newCreateScheduleStatus: BaseLoading()));
      DataState dataState = await createScheduleListUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newCreateScheduleStatus: BaseSuccess(dataState.data)));
        add(GetScheduleListEvent());
      } else {
        emit(state.copyWith(
            newCreateScheduleStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newCreateScheduleStatus: BaseNoAction()));
    });
    on<GetScheduleListEvent>((event, emit) async {
      emit(state.copyWith(newGetScheduleListStatus: BaseLoading()));
      DataState dataState = await getScheduleListUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetScheduleListStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetScheduleListStatus: BaseError(dataState.error)));
      }
      // emit(state.copyWith(newGetScheduleListStatus: BaseNoAction()));
    });
    on<GetScheduleByIdEvent>((event, emit) async {
      emit(state.copyWith(newGetScheduleByIdStatus: BaseLoading()));
      DataState dataState = await getScheduleByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetScheduleByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newGetScheduleByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetScheduleByIdStatus: BaseNoAction()));
    });
    on<DeleteScheduleByIdEvent>((event, emit) async {
      emit(state.copyWith(newDeleteScheduleByIdStatus: BaseLoading()));
      DataState dataState = await deleteScheduleByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        add(GetScheduleListEvent());
        emit(state.copyWith(
            newDeleteScheduleByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newDeleteScheduleByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeleteScheduleByIdStatus: BaseNoAction()));
    });
    on<PutScheduleByIdEvent>((event, emit) async {
      emit(state.copyWith(newPutScheduleByIdStatus: BaseLoading()));
      DataState dataState = await putScheduleByIdUseCase(event.params);
      if (dataState is DataSuccess) {
        add(GetScheduleListEvent());
        emit(state.copyWith(
            newPutScheduleByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newPutScheduleByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newPutScheduleByIdStatus: BaseNoAction()));
    });
    on<PatchScheduleByIdEvent>((event, emit) async {
      emit(state.copyWith(newPatchScheduleByIdStatus: BaseLoading()));
      DataState dataState = await patchScheduleByIdUseCase(event.params);
      if (dataState is DataSuccess) {
        add(GetScheduleListEvent());
        emit(state.copyWith(
            newPatchScheduleByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newPatchScheduleByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newPatchScheduleByIdStatus: BaseNoAction()));
    });
  }
}
