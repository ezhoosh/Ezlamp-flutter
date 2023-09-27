import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/domain/usecases/create_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/delete_group_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_by_id_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_group_list_usecase.dart';
import 'package:easy_lamp/domain/usecases/read_localstorage_usecase.dart';
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

  GroupBloc(
      this.writeLocalStorageUseCase,
      this.readLocalStorageUseCase,
      this.createGroupUseCase,
      this.deleteGroupUseCase,
      this.getGroupByIdUseCase,
      this.getGroupListUseCase,
      this.updateGroupOwnerUseCase,
      this.updateGroupUseCase)
      : super(GroupState(
            updateGroupStatus: BaseNoAction(),
            createGroupStatus: BaseNoAction(),
            deleteGroupStatus: BaseNoAction(),
            getGroupByIdStatus: BaseNoAction(),
            getGroupListStatus: BaseNoAction(),
            updateGroupOwnerStatus: BaseNoAction())) {}
}
