import 'package:easy_lamp/core/params/update_lamps_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';

class UpdateLampUseCase
    extends UseCase<DataState<LampModel>, UpdateLampListParams> {
  LampRepository repository;

  UpdateLampUseCase(this.repository);

  @override
  Future<DataState<LampModel>> call(UpdateLampListParams params) async {
    return await repository.updateLampById(params);
  }
}
