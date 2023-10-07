import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';

abstract class InternetBoxRepository {
  Future<DataState<List<InternetBoxModel>>> getInternetBoxList();

  Future<DataState<InternetBoxModel>> getInternetBoxById(int id);

  Future<DataState<InternetBoxModel>> updateInternetBox(
      UpdateGroupParams params);

  Future<DataState<InternetBoxModel>> createInternetBox(
      CreateGroupParams params);

  Future<DataState<InternetBoxModel>> editInternetBoxName(
      EditGroupNameParams params);

  Future<DataState<String>> deleteInternetBox(int params);

  Future<DataState<InternetBoxModel>> updateInternetBoxOwner(
      UpdateGroupOwnerParams params);
}
