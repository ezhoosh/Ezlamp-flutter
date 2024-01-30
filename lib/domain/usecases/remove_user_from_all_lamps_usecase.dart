import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';

class RemoveUserFromAllLampUseCase extends UseCase<DataState<String>, int> {
  InvitationRepository repository;

  RemoveUserFromAllLampUseCase(this.repository);

  @override
  Future<DataState<String>> call(int param) async {
    return await repository.removeUserFromAllLamp(param);
  }
}
