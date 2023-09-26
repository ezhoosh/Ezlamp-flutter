import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';

class GetGroupListUseCase
    extends UseCase<DataState<List<GroupLampModel>>, NoParams> {
  GroupRepository repository;

  GetGroupListUseCase(this.repository);

  @override
  Future<DataState<List<GroupLampModel>>> call(NoParams params) async {
    return await repository.getGroupList();
  }
}
