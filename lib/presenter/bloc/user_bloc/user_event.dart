part of 'user_bloc.dart';

abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  String lastName;
  String firstName;
  String email;

  UpdateUserEvent(
    this.lastName,
    this.firstName,
    this.email,
  );
}
