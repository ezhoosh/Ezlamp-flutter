import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class GetInternetBoxListUseCase
    extends UseCase<DataState<List<InternetBoxModel>>, NoParams> {
  InternetBoxRepository repository;

  GetInternetBoxListUseCase(this.repository);

  @override
  Future<DataState<List<InternetBoxModel>>> call(NoParams params) async {
    return await repository.getInternetBoxList();
  }
}
