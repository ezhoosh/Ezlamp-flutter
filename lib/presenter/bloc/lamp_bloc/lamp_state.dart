part of 'lamp_bloc.dart';

class LampState {
  BaseStatus getLampListStatus,
      getLampByIdStatus,
      updateLampOwnerStatus,
      updateLampStatus,
      patchLampStatus,
      deleteLampStatus;

  LampState(
      {required this.getLampByIdStatus,
      required this.deleteLampStatus,
      required this.getLampListStatus,
      required this.updateLampOwnerStatus,
      required this.patchLampStatus,
      required this.updateLampStatus});

  LampState copyWith(
      {BaseStatus? newGetLampListStatus,
      newGetLampByIdStatus,
      newUpdateLampOwnerStatus,
      newUpdateLampStatus,
      newPatchLampStatus,
      newDeleteLampStatus}) {
    return LampState(
      deleteLampStatus: newDeleteLampStatus ?? deleteLampStatus,
      updateLampStatus: newUpdateLampStatus ?? updateLampStatus,
      getLampByIdStatus: newGetLampByIdStatus ?? getLampByIdStatus,
      getLampListStatus: newGetLampListStatus ?? getLampListStatus,
      updateLampOwnerStatus: newUpdateLampOwnerStatus ?? updateLampOwnerStatus,
      patchLampStatus: newPatchLampStatus ?? patchLampStatus,
    );
  }
}
