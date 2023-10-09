import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';

class ReadConnectionUseCase extends UseCase<ConnectionType, NoParams> {
  LocalStorageRepository localStorageRepository;

  ReadConnectionUseCase(this.localStorageRepository);

  @override
  Future<ConnectionType> call(NoParams param) async {
    DataState type = await localStorageRepository
        .readStorageData(Constants.connectionTypeKey);
    return type.data.toString().endsWith("Bluetooth")
        ? ConnectionType.Bluetooth
        : ConnectionType.Internet;
  }
}
