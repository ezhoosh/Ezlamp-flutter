import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/params/patch_invitation_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';

class PutInvitationUseCase extends UseCase<DataState<InvitationModel>, UpdateInvitationParams> {
  InvitationRepository repository;

  PutInvitationUseCase(this.repository);

  @override
  Future<DataState<InvitationModel>> call(UpdateInvitationParams params) async {
    return await repository.putInvitation(params);
  }
}