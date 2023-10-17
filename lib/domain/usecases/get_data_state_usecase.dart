import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/domain/repositories/state_repository.dart';

class GetDataStateUseCase
    extends UseCase<DataState<List<StateModel>>, StateParams> {
  StateRepository repository;

  GetDataStateUseCase(this.repository);

  @override
  Future<DataState<List<StateModel>>> call(StateParams params) async {
    return await repository.getDataState(params);
  }
}
