import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/data/model/invitations_model.dart';

abstract class InvitationsRepository {
  Future<DataState<List<InvitationsModel>>> getInvitations();
}
