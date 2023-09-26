import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class DeleteGroupUseCase extends UseCase<DataState<String>, int> {
  GroupRepository repository;

  DeleteGroupUseCase(this.repository);

  @override
  Future<DataState<String>> call(int params) async {
    return await repository.deleteGroup(params);
  }
}
