import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/get_invitation_list_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/domain/repositories/auth_repository.dart';
import 'package:easy_lamp/domain/repositories/invitation_repository.dart';

class GetInvitationListUseCase
    extends UseCase<DataState<List<InvitationModel>>, GetInvitationListParams> {
  InvitationRepository repository;

  GetInvitationListUseCase(this.repository);

  @override
  Future<DataState<List<InvitationModel>>> call(
      GetInvitationListParams params) async {
    return await repository.getInvitationList(params);
  }
}
