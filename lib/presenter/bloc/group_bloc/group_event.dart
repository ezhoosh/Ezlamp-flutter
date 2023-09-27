part of 'group_bloc.dart';

@immutable
abstract class GroupEvent {}

class GetGroupListEvent extends GroupEvent {}

class GetGroupByIdEvent extends GroupEvent {}

class UpdateGroupOwnerEvent extends GroupEvent {}

class UpdateGroupEvent extends GroupEvent {}

class DeleteGroupEvent extends GroupEvent {}

class CreateGroupEvent extends GroupEvent {}
