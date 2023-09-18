
import 'package:easy_lamp/core/params/write_local_storage_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';

abstract class LocalStorageRepository {
  Future<DataState<String>> readStorageData(String key);

  Future<DataState<String?>> writeStorageData(WriteLocalStorageParam param);

  Future<DataState<String?>> deleteStorageData(String key);
}
