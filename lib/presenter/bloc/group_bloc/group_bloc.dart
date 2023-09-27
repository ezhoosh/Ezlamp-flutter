import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/usecases/create_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_name_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_owner_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/write_localstorage_usecase.dart';
import 'package:meta/meta.dart';

part 'group_event.dart';

part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GetGroupListUseCase getGroupListUseCase;
  GetGroupByIdUseCase getGroupByIdUseCase;
  UpdateGroupOwnerUseCase updateGroupOwnerUseCase;
  UpdateGroupUseCase updateGroupUseCase;
  DeleteGroupUseCase deleteGroupUseCase;
  CreateGroupUseCase createGroupUseCase;
  WriteLocalStorageUseCase writeLocalStorageUseCase;
  ReadLocalStorageUseCase readLocalStorageUseCase;
  UpdateGroupNameUseCase updateGroupNameUseCase;

  GroupBloc(
      this.writeLocalStorageUseCase,
      this.readLocalStorageUseCase,
      this.createGroupUseCase,
      this.deleteGroupUseCase,
      this.getGroupByIdUseCase,
      this.getGroupListUseCase,
      this.updateGroupOwnerUseCase,
      this.updateGroupUseCase,
      this.updateGroupNameUseCase)
      : super(GroupState(
            updateGroupStatus: BaseNoAction(),
            updateGroupNameStatus: BaseNoAction(),
            deleteGroupStatus: BaseNoAction(),
            getGroupByIdStatus: BaseNoAction(),
            getGroupListStatus: BaseNoAction(),
            updateGroupOwnerStatus: BaseNoAction())) {
    on<GetGroupListEvent>((event, emit) async {
      emit(state.copyWith(newGetGroupListStatus: BaseLoading()));
      DataState dataState = await getGroupListUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetGroupListStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetGroupListStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetGroupListStatus: BaseNoAction()));
    });
    on<GetGroupByIdEvent>((event, emit) async {
      emit(state.copyWith(newGetGroupByIdStatus: BaseLoading()));
      DataState dataState = await getGroupByIdUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetGroupByIdStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetGroupByIdStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetGroupByIdStatus: BaseNoAction()));
    });
    on<UpdateGroupEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupStatus: BaseLoading()));
      DataState dataState = await updateGroupUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newUpdateGroupStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newUpdateGroupStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateGroupStatus: BaseNoAction()));
    });
    on<UpdateGroupOwnerEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupOwnerStatus: BaseLoading()));
      DataState dataState = await updateGroupOwnerUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newUpdateGroupOwnerStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(
            newUpdateGroupOwnerStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newUpdateGroupOwnerStatus: BaseNoAction()));
    });
    on<DeleteGroupEvent>((event, emit) async {
      emit(state.copyWith(newDeleteGroupStatus: BaseLoading()));
      DataState dataState = await deleteGroupUseCase(event.id);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newDeleteGroupStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newDeleteGroupStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newDeleteGroupStatus: BaseNoAction()));
    });
    on<UpdateGroupNameEvent>((event, emit) async {
      emit(state.copyWith(newUpdateGroupNameStatus: BaseLoading()));
      DataState dataState = await updateGroupNameUseCase(event.params);
      if (dataState is DataSuccess) {
        add(GetGroupListEvent());
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
