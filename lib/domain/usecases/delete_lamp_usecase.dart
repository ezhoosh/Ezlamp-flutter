import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/repositories/Lamp_repository.dart';

class DeleteLampUseCase extends UseCase<DataState<String>, int> {
  LampRepository repository;

  DeleteLampUseCase(this.repository);

  @override
  Future<DataState<String>> call(int params) async {
    return await repository.deleteLamp(params);
  }
}
