part of 'lamp_bloc.dart';

class LampState {
  BaseStatus getLampListStatus,
      getLampByIdStatus,
      updateLampOwnerStatus,
      updateLampStatus,
      deleteLampStatus;

  LampState(
      {required this.getLampByIdStatus,
      required this.deleteLampStatus,
      required this.getLampListStatus,
      required this.updateLampOwnerStatus,
      required this.updateLampStatus});

  LampState copyWith(
      {BaseStatus? newGetLampListStatus,
      newGetLampByIdStatus,
      newUpdateLampOwnerStatus,
      newUpdateLampStatus,
      newDeleteLampStatus}) {
    return LampState(
        deleteLampStatus: newDeleteLampStatus ?? deleteLampStatus,
        updateLampStatus: newUpdateLampStatus ?? updateLampStatus,
        getLampByIdStatus: newGetLampByIdStatus ?? getLampByIdStatus,
        getLampListStatus: newGetLampListStatus ?? getLampListStatus,
        updateLampOwnerStatus:
            newUpdateLampOwnerStatus ?? updateLampOwnerStatus);
  }
}
