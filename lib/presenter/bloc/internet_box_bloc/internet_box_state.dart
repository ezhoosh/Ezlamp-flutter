part of 'internet_box_bloc.dart';

class InternetBoxState {
  BaseStatus getInternetBoxListStatus,
      getInternetBoxByIdStatus,
      updateInternetBoxOwnerStatus,
      updateInternetBoxStatus,
      deleteInternetBoxStatus,
      updateInternetBoxNameStatus;

  InternetBoxState(
      {required this.getInternetBoxByIdStatus,
      required this.updateInternetBoxNameStatus,
      required this.deleteInternetBoxStatus,
      required this.getInternetBoxListStatus,
      required this.updateInternetBoxOwnerStatus,
      required this.updateInternetBoxStatus});

  InternetBoxState copyWith(
      {BaseStatus? newGetGroupListStatus,
      newGetGroupByIdStatus,
      newUpdateGroupOwnerStatus,
      newUpdateGroupStatus,
      newDeleteGroupStatus,
      newUpdateGroupNameStatus}) {
    return InternetBoxState(
        updateInternetBoxNameStatus:
            newUpdateGroupNameStatus ?? updateInternetBoxNameStatus,
        deleteInternetBoxStatus:
            newDeleteGroupStatus ?? deleteInternetBoxStatus,
        updateInternetBoxStatus:
            newUpdateGroupStatus ?? updateInternetBoxStatus,
        getInternetBoxByIdStatus:
            newGetGroupByIdStatus ?? getInternetBoxByIdStatus,
        getInternetBoxListStatus:
            newGetGroupListStatus ?? getInternetBoxListStatus,
        updateInternetBoxOwnerStatus:
            newUpdateGroupOwnerStatus ?? updateInternetBoxOwnerStatus);
  }
}
