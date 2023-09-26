import 'package:easy_lamp/core/params/update_lamps_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/Lamp_repository.dart';

class UpdateLampUseCase
    extends UseCase<DataState<LampModel>, UpdateLampsParams> {
  LampRepository repository;

  UpdateLampUseCase(this.repository);

  @override
  Future<DataState<LampModel>> call(UpdateLampsParams params) async {
    return await repository.updateLampById(params);
  }
}
