import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/state_model.dart';
import 'package:easy_lamp/domain/repositories/state_repository.dart';

class GetDataStateInternetUseCase
    extends UseCase<DataState<List<StateModel>>, StateParams> {
  StateRepository repository;

  GetDataStateInternetUseCase(this.repository);

  @override
  Future<DataState<List<StateModel>>> call(StateParams params) async {
    return await repository.getDataStateInternet(params);
  }
}
