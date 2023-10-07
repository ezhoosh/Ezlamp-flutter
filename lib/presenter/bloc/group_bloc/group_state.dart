part of 'group_bloc.dart';

class GroupState {
  BaseStatus getGroupListStatus,
      getGroupByIdStatus,
      updateGroupOwnerStatus,
      updateGroupStatus,
      deleteGroupStatus,
      createGroupStatus,
      updateGroupNameStatus;

  GroupState(
      {required this.getGroupByIdStatus,
      required this.updateGroupNameStatus,
      required this.deleteGroupStatus,
      required this.getGroupListStatus,
      required this.updateGroupOwnerStatus,
      required this.createGroupStatus,
      required this.updateGroupStatus});

  GroupState copyWith(
      {BaseStatus? newGetGroupListStatus,
      newGetGroupByIdStatus,
      newUpdateGroupOwnerStatus,
      newUpdateGroupStatus,
      newDeleteGroupStatus,
      newCreateGroupStatus,
      newUpdateGroupNameStatus}) {
    return GroupState(
        updateGroupNameStatus:
            newUpdateGroupNameStatus ?? updateGroupNameStatus,
        deleteGroupStatus: newDeleteGroupStatus ?? deleteGroupStatus,
        updateGroupStatus: newUpdateGroupStatus ?? updateGroupStatus,
        getGroupByIdStatus: newGetGroupByIdStatus ?? getGroupByIdStatus,
        getGroupListStatus: newGetGroupListStatus ?? getGroupListStatus,
        createGroupStatus: newCreateGroupStatus ?? createGroupStatus,
        updateGroupOwnerStatus:
            newUpdateGroupOwnerStatus ?? updateGroupOwnerStatus);
  }
}
