import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';

abstract class InternetBoxRepository {
  Future<DataState<List<GroupLampModel>>> getInternetBoxList();

  Future<DataState<GroupLampModel>> getInternetBoxById(int id);

  Future<DataState<GroupLampModel>> updateInternetBox(UpdateGroupParams params);

  Future<DataState<GroupLampModel>> createInternetBox(CreateGroupParams params);

  Future<DataState<GroupLampModel>> editInternetBoxName(
      EditGroupNameParams params);

  Future<DataState<String>> deleteInternetBox(int params);

  Future<DataState<GroupLampModel>> updateInternetBoxOwner(
      UpdateGroupOwnerParams params);
}
