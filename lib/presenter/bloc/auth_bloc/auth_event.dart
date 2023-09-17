part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SendPhoneNumberEvent extends AuthEvent {
  SendPhoneNumberParams params;

  SendPhoneNumberEvent(this.params);
}
