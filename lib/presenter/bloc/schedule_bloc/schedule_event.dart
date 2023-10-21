part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent {}

class CreateScheduleEvent extends ScheduleEvent {
  CreateScheduleParams params;

  CreateScheduleEvent(this.params);
}

class PutScheduleByIdEvent extends ScheduleEvent {
  UpdateScheduleParams params;

  PutScheduleByIdEvent(this.params);
}

class PatchScheduleByIdEvent extends ScheduleEvent {
  UpdateScheduleParams params;

  PatchScheduleByIdEvent(this.params);
}

class DeleteScheduleByIdEvent extends ScheduleEvent {
  int id;

  DeleteScheduleByIdEvent(this.id);
}

class GetScheduleByIdEvent extends ScheduleEvent {
  int id;

  GetScheduleByIdEvent(this.id);
}

class GetScheduleListEvent extends ScheduleEvent {}
