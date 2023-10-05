part of 'internet_box_bloc.dart';

@immutable
abstract class InternetBoxEvent {}

class GetInternetBoxListEvent extends InternetBoxEvent {}

class GetInternetBoxByIdEvent extends InternetBoxEvent {
  int id;

  GetInternetBoxByIdEvent(this.id);
}

class UpdateInternetBoxOwnerEvent extends InternetBoxEvent {
  UpdateGroupOwnerParams params;

  UpdateInternetBoxOwnerEvent(this.params);
}

class UpdateInternetBoxEvent extends InternetBoxEvent {
  UpdateGroupParams params;

  UpdateInternetBoxEvent(this.params);
}

class DeleteInternetBoxEvent extends InternetBoxEvent {
  int id;

  DeleteInternetBoxEvent(this.id);
}

class UpdateInternetBoxNameEvent extends InternetBoxEvent {
  EditGroupNameParams params;

  UpdateInternetBoxNameEvent(this.params);
}
