part of 'invitation_bloc.dart';

@immutable
abstract class InvitationEvent {}

class GetInvitationListEvent extends InvitationEvent {
  GetInvitationListParams params;

  GetInvitationListEvent(this.params);
}

class GetMyInvitationAssignmentListEvent extends InvitationEvent {}

class GetInvitationByIdEvent extends InvitationEvent {
  int id;

  GetInvitationByIdEvent(this.id);
}

class GetInvitationByGroupIdEvent extends InvitationEvent {
  int groupId;

  GetInvitationByGroupIdEvent(this.groupId);
}

class DeleteInvitationEvent extends InvitationEvent {
  int id;

  DeleteInvitationEvent(this.id);
}

class RemoveUserFromAllLampEvent extends InvitationEvent {
  int id;

  RemoveUserFromAllLampEvent(this.id);
}

class CreateInvitationEvent extends InvitationEvent {
  CreateInvitationParams params;

  CreateInvitationEvent(this.params);
}

class CreateInvitationGroupEvent extends InvitationEvent {
  CreateInvitationGroupParams params;

  CreateInvitationGroupEvent(this.params);
}

class PutInvitationEvent extends InvitationEvent {
  UpdateInvitationParams params;

  PutInvitationEvent(this.params);
}

class PatchInvitationEvent extends InvitationEvent {
  UpdateInvitationParams params;

  PatchInvitationEvent(this.params);
}

class AcceptInviteEvent extends InvitationEvent {
  int id;

  AcceptInviteEvent(this.id);
}

class DeclineInviteEvent extends InvitationEvent {
  int id;

  DeclineInviteEvent(this.id);
}
