part of 'lamp_bloc.dart';

@immutable
abstract class LampEvent {}

class GetLampListEvent extends LampEvent {
  GetLampListParams params;

  GetLampListEvent(this.params);
}

class GetLampByIdEvent extends LampEvent {
  int id;

  GetLampByIdEvent(this.id);
}

class UpdateLampOwnerEvent extends LampEvent {
  UpdateLampOwnerParams params;

  UpdateLampOwnerEvent(this.params);
}

class UpdateLampEvent extends LampEvent {
  UpdateLampListParams params;

  UpdateLampEvent(this.params);
}

class DeleteLampEvent extends LampEvent {
  int id;

  DeleteLampEvent(this.id);
}

class PatchLampEvent extends LampEvent {
  PatchLampListParams params;

  PatchLampEvent(this.params);
}
