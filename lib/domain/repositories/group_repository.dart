import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';

abstract class GroupRepository {
  Future<DataState<List<GroupModel>>> getGroupList();

  Future<DataState<GroupModel>> getGroupById(int id);

  Future<DataState<GroupModel>> updateGroup(UpdateGroupParams params);

  Future<DataState<GroupModel>> createGroup(CreateGroupParams params);

  Future<DataState<GroupModel>> editGroupName(EditGroupNameParams params);

  Future<DataState<String>> deleteGroup(int params);

  Future<DataState<GroupModel>> updateGroupOwner(
      UpdateGroupOwnerParams params);
}
