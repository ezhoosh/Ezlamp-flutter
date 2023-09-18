
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';

class ReadLocalStorageUseCase extends UseCase<DataState<String>, String> {
  LocalStorageRepository localStorageRepository;

  ReadLocalStorageUseCase(this.localStorageRepository);

  @override
  Future<DataState<String>> call(String param) async {
    return await localStorageRepository.readStorageData(param);
  }
}
