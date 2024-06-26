import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/params/update_lamps_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/core/utils/converter.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/data/repositories/isar_lamp_repository.dart';
import 'package:easy_lamp/domain/usecases/delete_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_lamp_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/patch_lamp_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_name_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_lamp_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_lamp_usecase.dart';
import 'package:meta/meta.dart';

part 'lamp_event.dart';

part 'lamp_state.dart';

class LampBloc extends Bloc<LampEvent, LampState> {
  GetLampListUseCase getLampListUseCase;
  GetLampByIdUseCase getLampByIdUseCase;
  UpdateLampOwnerUseCase updateLampOwnerUseCase;
  UpdateLampUseCase updateLampUseCase;
  PatchLampUseCase patchLampUseCase;
  DeleteLampUseCase deleteLampUseCase;
  ReadConnectionUseCase readConnectionUseCase;
  IsarLampRepository? isarLampRepository;

  LampBloc(
    this.updateLampOwnerUseCase,
    this.updateLampUseCase,
    this.getLampByIdUseCase,
    this.getLampListUseCase,
    this.deleteLampUseCase,
    this.readConnectionUseCase,
    this.patchLampUseCase,
    this.isarLampRepository,
  ) : super(LampState(
          getLampByIdStatus: BaseNoAction(),
          deleteLampStatus: BaseNoAction(),
          getLampListStatus: BaseNoAction(),
          updateLampOwnerStatus: BaseNoAction(),
          updateLampStatus: BaseNoAction(),
          patchLampStatus: BaseNoAction(),
        )) {
    on<GetLampListEvent>((event, emit) async {
      emit(state.copyWith(newGetLampListStatus: BaseLoading()));
      ConnectionType type = await readConnectionUseCase(NoParams());
      if (type == ConnectionType.Bluetooth) {
        List<LampModel> lamps = Converter.isarLampToLampModel(
            await isarLampRepository!.getByGroupId(event.params.groupId ?? 0));
        emit(state.copyWith(newGetLampListStatus: BaseSuccess(lamps)));
      } else {
        DataState dataState = await getLampListUseCase(event.params);
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newGetLampListStatus: BaseSuccess(dataState.data)));
        } else {
          emit(
              state.copyWith(newGetLampListStatus: BaseError(dataState.error)));
        }
      }
      // emit(state.copyWith(newGetLampListStatus: BaseNoAction()));
    });
    on<GetLampByIdEvent>((event, emit) async {
      emit(state.copyWith(newGetLampByIdStatus: BaseLoading()));
      DataState dataState = await getLampByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newGetLampByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetLampByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetLampByIdStatus: BaseNoAction()));
    });
    on<UpdateLampEvent>((event, emit) async {
      emit(state.copyWith(newUpdateLampStatus: BaseLoading()));
      DataState dataState = await updateLampUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newUpdateLampStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newUpdateLampStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateLampStatus: BaseNoAction()));
    });
    on<PatchLampEvent>((event, emit) async {
      emit(state.copyWith(newPatchLampStatus: BaseLoading()));
      DataState dataState = await patchLampUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newPatchLampStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newPatchLampStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newPatchLampStatus: BaseNoAction()));
    });
    on<UpdateLampOwnerEvent>((event, emit) async {
      emit(state.copyWith(newUpdateLampOwnerStatus: BaseLoading()));
      DataState dataState = await updateLampOwnerUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newUpdateLampOwnerStatus: BaseSuccess(dataState.data)));
        add(GetLampListEvent(
            GetLampListParams(groupId: event.params.groupLamp)));
      } else {
        emit(state.copyWith(
            newUpdateLampOwnerStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateLampOwnerStatus: BaseNoAction()));
    });
    on<DeleteLampEvent>((event, emit) async {
      emit(state.copyWith(newDeleteLampStatus: BaseLoading()));
      DataState dataState = await deleteLampUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newDeleteLampStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newDeleteLampStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeleteLampStatus: BaseNoAction()));
    });
  }
}
