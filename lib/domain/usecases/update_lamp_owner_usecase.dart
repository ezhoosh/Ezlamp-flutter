import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/lamp_repository.dart';

class UpdateLampOwnerUseCase
    extends UseCase<DataState<LampModel>, UpdateLampOwnerParams> {
  LampRepository repository;

  UpdateLampOwnerUseCase(this.repository);

  @override
  Future<DataState<LampModel>> call(UpdateLampOwnerParams params) async {
    return await repository.updateLampOwner(params);
  }
}
