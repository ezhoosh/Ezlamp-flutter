part of 'schedule_bloc.dart';

@immutable
class ScheduleState {
  BaseStatus createScheduleListStatus,
      putScheduleByIdStatus,
      patchScheduleByIdStatus,
      deleteScheduleByIdStatus,
      getScheduleByIdStatus,
      getScheduleListStatus;

  ScheduleState(
      {required this.createScheduleListStatus,
      required this.putScheduleByIdStatus,
      required this.patchScheduleByIdStatus,
      required this.deleteScheduleByIdStatus,
      required this.getScheduleByIdStatus,
      required this.getScheduleListStatus});

  ScheduleState copyWith(
      {BaseStatus? newCreateScheduleStatus,
      newPutScheduleByIdStatus,
      newPatchScheduleByIdStatus,
      newDeleteScheduleByIdStatus,
      newGetScheduleByIdStatus,
      newGetScheduleListStatus}) {
    return ScheduleState(
        createScheduleListStatus:
            newCreateScheduleStatus ?? createScheduleListStatus,
        putScheduleByIdStatus:
            newPutScheduleByIdStatus ?? putScheduleByIdStatus,
        patchScheduleByIdStatus:
            newPatchScheduleByIdStatus ?? patchScheduleByIdStatus,
        deleteScheduleByIdStatus:
            newDeleteScheduleByIdStatus ?? deleteScheduleByIdStatus,
        getScheduleByIdStatus:
            newGetScheduleByIdStatus ?? getScheduleByIdStatus,
        getScheduleListStatus:
            newGetScheduleListStatus ?? getScheduleListStatus);
  }
}
