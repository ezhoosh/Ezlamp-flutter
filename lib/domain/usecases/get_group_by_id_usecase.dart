import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class GetGroupByIdUseCase extends UseCase<DataState<GroupModel>, int> {
  GroupRepository repository;

  GetGroupByIdUseCase(this.repository);

  @override
  Future<DataState<GroupModel>> call(int params) async {
    return await repository.getGroupById(params);
  }
}
