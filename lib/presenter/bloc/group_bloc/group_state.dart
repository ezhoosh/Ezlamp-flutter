part of 'group_bloc.dart';

class GroupState {
  BaseStatus getGroupListStatus,
      getGroupByIdStatus,
      updateGroupOwnerStatus,
      updateGroupStatus,
      deleteGroupStatus,
      createGroupStatus;
  GroupState(
      {required this.getGroupByIdStatus,
      required this.createGroupStatus,
      required this.deleteGroupStatus,
      required this.getGroupListStatus,
      required this.updateGroupOwnerStatus,
      required this.updateGroupStatus});

  GroupState copyWith(
      BaseStatus? newGetGroupListStatus,
      newGetGroupByIdStatus,
      newUpdateGroupOwnerStatus,
      newUpdateGroupStatus,
      newDeleteGroupStatus,
      newCreateGroupStatus) {
    return GroupState(
        createGroupStatus: newCreateGroupStatus ?? createGroupStatus,
        deleteGroupStatus: newDeleteGroupStatus ?? deleteGroupStatus,
        updateGroupStatus: newUpdateGroupStatus ?? updateGroupStatus,
        getGroupByIdStatus: newGetGroupByIdStatus ?? getGroupByIdStatus,
        getGroupListStatus: newGetGroupListStatus ?? getGroupListStatus,
        updateGroupOwnerStatus:
            newUpdateGroupOwnerStatus ?? updateGroupOwnerStatus);
  }
}
