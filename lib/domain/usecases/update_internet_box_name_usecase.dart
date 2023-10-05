import 'package:easy_lamp/core/params/edit_group_name_params.dart';
import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class UpdateInternetBoxNameUseCase
    extends UseCase<DataState<GroupLampModel>, EditGroupNameParams> {
  InternetBoxRepository repository;

  UpdateInternetBoxNameUseCase(this.repository);

  @override
  Future<DataState<GroupLampModel>> call(EditGroupNameParams params) async {
    return await repository.editInternetBoxName(params);
  }
}
