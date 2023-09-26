import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/repositories/Lamp_repository.dart';

class GetLampListUseCase
    extends UseCase<DataState<List<LampModel>>, GetLampsParams> {
  LampRepository repository;

  GetLampListUseCase(this.repository);

  @override
  Future<DataState<List<LampModel>>> call(GetLampsParams params) async {
    return await repository.getLampList(params);
  }
}
