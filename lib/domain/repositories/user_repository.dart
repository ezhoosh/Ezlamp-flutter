import 'package:easy_lamp/core/params/create_group_params.dart';
import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/user_model.dart';

abstract class UserRepository {
  Future<DataState<UserModel>> updateUser(UserParams params);

  Future<DataState<UserModel>> getUser();
}
