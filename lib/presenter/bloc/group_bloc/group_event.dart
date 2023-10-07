part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class GetGroupListEvent extends GroupEvent {}

class GetGroupByIdEvent extends GroupEvent {
  int id;

  GetGroupByIdEvent(this.id);
}

class UpdateGroupOwnerEvent extends GroupEvent {
  UpdateGroupOwnerParams params;

  UpdateGroupOwnerEvent(this.params);
}

class UpdateGroupEvent extends GroupEvent {
  UpdateGroupParams params;

  UpdateGroupEvent(this.params);
}

class DeleteGroupEvent extends GroupEvent {
  int id;

  DeleteGroupEvent(this.id);
}

class UpdateGroupNameEvent extends GroupEvent {
  EditGroupNameParams params;

  UpdateGroupNameEvent(this.params);
}

class CreateGroupEvent extends GroupEvent {
  String name;
  String desc;

  CreateGroupEvent(this.name, this.desc);
}
