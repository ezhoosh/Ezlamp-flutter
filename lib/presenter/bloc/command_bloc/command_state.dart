part of 'command_bloc.dart';

class CommandState {
  BaseStatus sendCommandStatus;
  BluetoothDevice? deviceConnected;

  CommandState({
    required this.sendCommandStatus,
    this.deviceConnected,
  });

  CommandState copyWith({
    BaseStatus? newSendCommandStatus,
    BluetoothDevice? newDeviceConnected,
  }) {
    return CommandState(
      sendCommandStatus: newSendCommandStatus ?? sendCommandStatus,
      deviceConnected: newDeviceConnected ?? deviceConnected,
    );
  }
}
