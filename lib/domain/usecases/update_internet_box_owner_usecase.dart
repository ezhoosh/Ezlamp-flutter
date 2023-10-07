import 'package:easy_lamp/core/params/update_group_owner_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class UpdateInternetBoxOwnerUseCase
    extends UseCase<DataState<InternetBoxModel>, UpdateGroupOwnerParams> {
  InternetBoxRepository repository;

  UpdateInternetBoxOwnerUseCase(this.repository);

  @override
  Future<DataState<InternetBoxModel>> call(UpdateGroupOwnerParams params) async {
    return await repository.updateInternetBoxOwner(params);
  }
}
