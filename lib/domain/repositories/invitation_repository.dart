import 'package:easy_lamp/core/params/change_password_params.dart';
import 'package:easy_lamp/core/params/create_invitation_params.dart';
import 'package:easy_lamp/core/params/get_invitation_list_params.dart';
import 'package:easy_lamp/core/params/patch_invitation_params.dart';
import 'package:easy_lamp/core/params/register_verify_params.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/params/send_phone_number_params.dart';
import 'package:easy_lamp/core/params/login_params.dart';
import 'package:easy_lamp/data/model/invitation_model.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/data/model/register_verify_model.dart';
import 'package:easy_lamp/data/model/reset_password_model.dart';
import 'package:easy_lamp/data/model/send_login_otp.dart';
import 'package:easy_lamp/data/model/send_number_model.dart';
import 'package:easy_lamp/presenter/pages/profile_feature/change_password_page.dart';

abstract class InvitationRepository {
  Future<DataState<List<InvitationModel>>> getInvitationList(
      GetInvitationListParams params);

  Future<DataState<List<InvitationModel>>> getMyInvitationAssignmentList();

  Future<DataState<InvitationModel>> getInvitationGetById(int id);

  Future<DataState<InvitationModel>> getInvitationGroupGetById(int groupId);

  Future<DataState<String>> deleteInvitationGetById(int id);

  Future<DataState<String>> createInvitation(CreateInvitationParams params);

  Future<DataState<InvitationModel>> putInvitation(
      UpdateInvitationParams params);

  Future<DataState<InvitationModel>> patchInvitation(
      UpdateInvitationParams params);

  Future<DataState<String>> acceptInvite(int id);

  Future<DataState<String>> declineInvite(int id);
}
