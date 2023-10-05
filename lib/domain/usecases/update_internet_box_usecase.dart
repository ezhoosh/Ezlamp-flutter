import 'package:easy_lamp/core/params/update_group_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/domain/repositories/group_repository.dart';
import 'package:easy_lamp/domain/repositories/internet_box_repository.dart';

class UpdateInternetBoxUseCase
    extends UseCase<DataState<GroupLampModel>, UpdateGroupParams> {
  InternetBoxRepository repository;

  UpdateInternetBoxUseCase(this.repository);

  @override
  Future<DataState<GroupLampModel>> call(UpdateGroupParams params) async {
    return await repository.updateInternetBox(params);
  }
}
