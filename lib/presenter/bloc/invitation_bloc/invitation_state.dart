part of 'invitation_bloc.dart';

class InvitationState {
  BaseStatus getInvitationListStatus,
      getMyInvitationAssignmentListStatus,
      getInvitationByIdStatus,
      getInvitationByGroupIdStatus,
      deleteInvitationStatus,
      createInvitationStatus,
      putInvitationStatus,
      patchInvitationStatus,
      acceptInviteStatus,
      declineInviteStatus;

  InvitationState(
      {required this.getInvitationListStatus,
      required this.getMyInvitationAssignmentListStatus,
      required this.getInvitationByIdStatus,
      required this.getInvitationByGroupIdStatus,
      required this.deleteInvitationStatus,
      required this.createInvitationStatus,
      required this.putInvitationStatus,
      required this.patchInvitationStatus,
      required this.acceptInviteStatus,
      required this.declineInviteStatus});

  InvitationState copyWith(
      {BaseStatus? newGetInvitationListStatus,
      newGetMyInvitationAssignmentListStatus,
      newGetInvitationByIdStatus,
      newGetInvitationByGroupIdStatus,
      newDeleteInvitationStatus,
      newCreateInvitationStatus,
      newPutInvitationStatus,
      newPatchInvitationStatus,
      newAcceptInviteStatus,
      newDeclineInviteStatus}) {
    return InvitationState(
      getMyInvitationAssignmentListStatus:
          newGetMyInvitationAssignmentListStatus ??
              getMyInvitationAssignmentListStatus,
      getInvitationListStatus:
          newGetInvitationListStatus ?? getInvitationListStatus,
      getInvitationByIdStatus:
          newGetInvitationByIdStatus ?? getInvitationByIdStatus,
      getInvitationByGroupIdStatus:
          newGetInvitationByGroupIdStatus ?? getInvitationByGroupIdStatus,
      deleteInvitationStatus:
          newDeleteInvitationStatus ?? deleteInvitationStatus,
      createInvitationStatus:
          newCreateInvitationStatus ?? createInvitationStatus,
      patchInvitationStatus: newPatchInvitationStatus ?? patchInvitationStatus,
      putInvitationStatus: newPutInvitationStatus ?? putInvitationStatus,
      acceptInviteStatus: newAcceptInviteStatus ?? acceptInviteStatus,
      declineInviteStatus: newDeclineInviteStatus ?? declineInviteStatus,
    );
  }
}
