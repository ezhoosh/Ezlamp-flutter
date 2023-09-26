import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';

abstract class GroupRepository {
  Future<DataState<List<GroupLampModel>>> getGroupList();
  Future<DataState<GroupLampModel>> getGroupById(int id);
  Future<DataState<GroupLampModel>> updateGroup(UpdateGroupParams params);
  Future<DataState<GroupLampModel>> createGroup(CreateGroupParams params);
  Future<DataState<String>> deleteGroup(int params);
  Future<DataState<GroupLampModel>> updateGroupOwner(
      UpdateGroupOwnerParams params);
}
