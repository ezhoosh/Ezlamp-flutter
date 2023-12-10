import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/core/utils/converter.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/data/repositories/isar_internet_box_repository.dart';
import 'package:easy_lamp/domain/usecases/create_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_internet_box_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_internet_box_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_name_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_internet_box_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_internet_box_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'internet_box_event.dart';

part 'internet_box_state.dart';

class InternetBoxBloc extends Bloc<InternetBoxEvent, InternetBoxState> {
  GetInternetBoxListUseCase getInternetBoxListUseCase;
  GetInternetBoxByIdUseCase getInternetByIdUseCase;
  UpdateInternetBoxOwnerUseCase updateInternetBoxOwnerUseCase;
  UpdateInternetBoxUseCase updateInternetBoxUseCase;
  DeleteInternetBoxUseCase deleteInternetBoxUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  ReadLocalStorageUseCase readLocalStorageUseCase;
  UpdateGroupNameUseCase updateGroupNameUseCase;
  IsarInternetBoxRepository? isarInternetBoxRepository;
  ReadConnectionUseCase readConnectionUseCase;

  InternetBoxBloc(
    this.writeLocalStorageUseCase,
    this.readLocalStorageUseCase,
    this.deleteInternetBoxUseCase,
    this.getInternetByIdUseCase,
    this.getInternetBoxListUseCase,
    this.updateInternetBoxOwnerUseCase,
    this.updateInternetBoxUseCase,
    this.updateGroupNameUseCase,
    this.readConnectionUseCase,
    this.isarInternetBoxRepository,
  ) : super(InternetBoxState(
            updateInternetBoxStatus: BaseNoAction(),
            updateInternetBoxNameStatus: BaseNoAction(),
            deleteInternetBoxStatus: BaseNoAction(),
            getInternetBoxByIdStatus: BaseNoAction(),
            getInternetBoxListStatus: BaseNoAction(),
            updateInternetBoxOwnerStatus: BaseNoAction())) {
    on<GetInternetBoxListEvent>((event, emit) async {
      emit(state.copyWith(newGetGroupListStatus: BaseLoading()));
      ConnectionType type = await readConnectionUseCase(NoParams());
      if (type == ConnectionType.Bluetooth) {
        List<InternetBoxModel> groups =
            Converter.isarInternetBoxToInternetBoxModel(
                await isarInternetBoxRepository!.getAll());
        emit(state.copyWith(newGetGroupListStatus: BaseSuccess(groups)));
      } else {
        DataState dataState = await getInternetBoxListUseCase(NoParams());
        if (!kIsWeb) {
          await isarInternetBoxRepository!.saveAll(
              Converter.internetBoxModelToIsarInternetBox(dataState.data));
        }
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newGetGroupListStatus: BaseSuccess(dataState.data)));
        } else {
          emit(state.copyWith(
              newGetGroupListStatus: BaseError(dataState.error)));
        }
      }
      emit(state.copyWith(newGetGroupListStatus: BaseNoAction()));
    });
    on<GetInternetBoxByIdEvent>((event, emit) async {
      emit(state.copyWith(newGetGroupByIdStatus: BaseLoading()));
      DataState dataState = await getInternetByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetGroupByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetGroupByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetGroupByIdStatus: BaseNoAction()));
    });
    on<UpdateInternetBoxEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupStatus: BaseLoading()));
      DataState dataState = await updateInternetBoxUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newUpdateGroupStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newUpdateGroupStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateGroupStatus: BaseNoAction()));
    });
    on<UpdateInternetBoxOwnerEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupOwnerStatus: BaseLoading()));
      DataState dataState = await updateInternetBoxOwnerUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newUpdateGroupOwnerStatus: BaseSuccess(dataState.data)));
        add(GetInternetBoxListEvent());
      } else {
        emit(state.copyWith(
            newUpdateGroupOwnerStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateGroupOwnerStatus: BaseNoAction()));
    });
    on<DeleteInternetBoxEvent>((event, emit) async {
      emit(state.copyWith(newDeleteGroupStatus: BaseLoading()));
      DataState dataState = await deleteInternetBoxUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newDeleteGroupStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newDeleteGroupStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeleteGroupStatus: BaseNoAction()));
    });
    on<UpdateInternetBoxNameEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupNameStatus: BaseLoading()));
      DataState dataState = await updateGroupNameUseCase(event.params);
      if (dataState is DataSuccess) {
        add(GetInternetBoxListEvent());
        emit(state.copyWith(
            newUpdateGroupNameStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newUpdateGroupNameStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateGroupNameStatus: BaseNoAction()));
    });
  }
}
