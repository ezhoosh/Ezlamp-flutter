
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/utils/local_data_provider.dart';
import 'package:easy_lamp/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  LocalDataProvider localDataProvider;

  LocalStorageRepositoryImpl(this.localDataProvider);

  @override
  Future<DataState<String?>> deleteStorageData(String key) async {
    try {
      await localDataProvider.deleteStorage(key);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> readStorageData(String key) async {
    try {
      String data = await localDataProvider.readStorage(key);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String?>> writeStorageData(
      WriteLocalStorageParam param) async {
    try {
      await localDataProvider.writeStorage(param.key, param.value);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
