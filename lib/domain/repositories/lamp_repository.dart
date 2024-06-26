import 'package:easy_lamp/core/params/get_lamps_params.dart';
import 'package:easy_lamp/core/params/patch_lamps_params.dart';
import 'package:easy_lamp/core/params/update_lamps_owner_params.dart';
import 'package:easy_lamp/core/params/update_lamps_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';

abstract class LampRepository {
  Future<DataState<List<LampModel>>> getLampList(GetLampListParams params);

  Future<DataState<LampModel>> getLampById(int id);

  Future<DataState<LampModel>> updateLampById(UpdateLampListParams params);

  Future<DataState<LampModel>> patchLampById(PatchLampListParams params);

  Future<DataState<String>> deleteLamp(int params);

  Future<DataState<LampModel>> updateLampOwner(UpdateLampOwnerParams params);
}
