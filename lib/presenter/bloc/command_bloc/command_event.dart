part of 'command_bloc.dart';

class CommandEvent {}

class SendCommandEvent extends CommandEvent {
  CommandParams commandParams;

  SendCommandEvent(this.commandParams);
}

class ConnectedBlueEvent extends CommandEvent {
  BluetoothDevice device;

  ConnectedBlueEvent(this.device);
}
