import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class UpdateGroupOwnerUseCase
    extends UseCase<DataState<GroupModel>, UpdateGroupOwnerParams> {
  GroupRepository repository;

  UpdateGroupOwnerUseCase(this.repository);

  @override
  Future<DataState<GroupModel>> call(UpdateGroupOwnerParams params) async {
    return await repository.updateGroupOwner(params);
  }
}
