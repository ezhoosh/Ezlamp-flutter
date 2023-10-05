import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class DeleteInternetBoxUseCase extends UseCase<DataState<String>, int> {
  InternetBoxRepository repository;

  DeleteInternetBoxUseCase(this.repository);

  @override
  Future<DataState<String>> call(int params) async {
    return await repository.deleteInternetBox(params);
  }
}
