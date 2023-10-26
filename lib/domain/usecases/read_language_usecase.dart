import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/data/model/language_type.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';

class ReadLanguageUseCase extends UseCase<LanguageType, NoParams> {
  LocalStorageRepository localStorageRepository;

  ReadLanguageUseCase(this.localStorageRepository);

  @override
  Future<LanguageType> call(NoParams param) async {
    DataState type =
        await localStorageRepository.readStorageData(Constants.languageKey);
    return type.data.toString().endsWith("EN")
        ? LanguageType.EN
        : LanguageType.PS;
  }
}
