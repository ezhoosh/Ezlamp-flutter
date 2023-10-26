import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class UpdateGroupUseCase
    extends UseCase<DataState<GroupModel>, UpdateGroupParams> {
  GroupRepository repository;

  UpdateGroupUseCase(this.repository);

  @override
  Future<DataState<GroupModel>> call(UpdateGroupParams params) async {
    return await repository.updateGroup(params);
  }
}
