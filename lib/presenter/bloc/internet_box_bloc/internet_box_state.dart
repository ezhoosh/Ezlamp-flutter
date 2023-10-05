part of 'internet_box_bloc.dart';

class InternetBoxState {
  BaseStatus getGroupListStatus,
      getGroupByIdStatus,
      updateGroupOwnerStatus,
      updateGroupStatus,
      deleteGroupStatus,
      updateGroupNameStatus;

  InternetBoxState(
      {required this.getGroupByIdStatus,
      required this.updateGroupNameStatus,
      required this.deleteGroupStatus,
      required this.getGroupListStatus,
      required this.updateGroupOwnerStatus,
      required this.updateGroupStatus});

  InternetBoxState copyWith(
      {BaseStatus? newGetGroupListStatus,
      newGetGroupByIdStatus,
      newUpdateGroupOwnerStatus,
      newUpdateGroupStatus,
      newDeleteGroupStatus,
      newUpdateGroupNameStatus}) {
    return InternetBoxState(
        updateGroupNameStatus:
            newUpdateGroupNameStatus ?? updateGroupNameStatus,
        deleteGroupStatus: newDeleteGroupStatus ?? deleteGroupStatus,
        updateGroupStatus: newUpdateGroupStatus ?? updateGroupStatus,
        getGroupByIdStatus: newGetGroupByIdStatus ?? getGroupByIdStatus,
        getGroupListStatus: newGetGroupListStatus ?? getGroupListStatus,
        updateGroupOwnerStatus:
            newUpdateGroupOwnerStatus ?? updateGroupOwnerStatus);
  }
}
