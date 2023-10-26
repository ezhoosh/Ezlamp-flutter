import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class CreateGroupUseCase
    extends UseCase<DataState<GroupModel>, CreateGroupParams> {
  GroupRepository repository;

  CreateGroupUseCase(this.repository);

  @override
  Future<DataState<GroupModel>> call(CreateGroupParams params) async {
    return await repository.createGroup(params);
  }
}
