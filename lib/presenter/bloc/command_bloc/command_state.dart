part of 'command_bloc.dart';

class CommandState {
  BaseStatus sendCommandStatus;

  CommandState({required this.sendCommandStatus});

  CommandState copyWith({
    BaseStatus? newSendCommandStatus,
  }) {
    return CommandState(
        sendCommandStatus: newSendCommandStatus ?? sendCommandStatus);
  }
}
