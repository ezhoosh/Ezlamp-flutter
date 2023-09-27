import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';

class GetLampByIdUseCase extends UseCase<DataState<LampModel>, int> {
  LampRepository repository;

  GetLampByIdUseCase(this.repository);

  @override
  Future<DataState<LampModel>> call(int params) async {
    return await repository.getLampById(params);
  }
}
