import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/connection_type.dart';
import 'package:easy_lamp/domain/usecases/read_connection_usecase.dart';
import 'package:easy_lamp/domain/usecases/send_command_usecase.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';

part 'command_event.dart';

part 'command_state.dart';

class CommandBloc extends Bloc<CommandEvent, CommandState> {
  SendCommandUseCase sendCommandUseCase;
  ReadConnectionUseCase readConnectionUseCase;

  CommandBloc(this.sendCommandUseCase, this.readConnectionUseCase)
      : super(CommandState(
          sendCommandStatus: BaseNoAction(),
        )) {
    on<SendCommandEvent>((event, emit) async {
      if (await readConnectionUseCase(NoParams()) == ConnectionType.Internet) {
        emit(state.copyWith(newSendCommandStatus: BaseLoading()));
        DataState dataState = await sendCommandUseCase(event.commandParams);
        if (dataState is DataSuccess) {
          emit(state.copyWith(
              newSendCommandStatus: BaseSuccess(dataState.data)));
        } else {
          emit(
              state.copyWith(newSendCommandStatus: BaseError(dataState.error)));
        }
        emit(state.copyWith(newSendCommandStatus: BaseNoAction()));
      } else {
        final data = event.commandParams.toBlueJson();
        // if (data is List) {
        //   emit(state.copyWith(newSendCommandStatus: BaseLoading()));
        //
        //   for (String da in data) {
        //     await Future.delayed(const Duration(seconds: 1));
        //     await sendData(state.deviceConnected, da);
        //   }
        //   emit(state.copyWith(newSendCommandStatus: BaseSuccess('')));
        //   // [  +19 ms] I/flutter (13957): send : {"type":"apply","uid":"000003","c":0,"w":0,"y":0,"r":99,"g":3,"b":3,"pir":1}
        // } else if (data is String) {
        print('send single: $data');
        await sendData(state.deviceConnected, data);
        // }
      }
    });
    on<ConnectedBlueEvent>((event, emit) {
      emit(state.copyWith(newDeviceConnected: event.device));
    });
  }

  sendData(BluetoothDevice? deviceConnected, String data) async {
    if (state.deviceConnected != null && state.deviceConnected!.isConnected) {
      await state.deviceConnected!.connect();
      List<BluetoothService> services =
          await state.deviceConnected!.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == '0000fff0-0000-1000-8000-00805f9b34fb') {
          for (var characteristic in service.characteristics) {
            if (characteristic.properties.write) {
              // const maxWriteLength = 10;
              final dataBytes = utf8.encode(data);
              Future<void> f =
                  characteristic.write(dataBytes, allowLongWrite: true);
              f.then((value) {
                print('value.toString()');
              });
              f.catchError((e) {
                print(e.toString());
              });
              // for (int i = 0; i < dataBytes.length; i += maxWriteLength) {
              //   final end = (i + maxWriteLength < dataBytes.length)
              //       ? i + maxWriteLength
              //       : dataBytes.length;
              //   final chunk = dataBytes.sublist(i, end);
              //   Future<void> f = characteristic.write(chunk);
              //   f.then((value) {
              //     print('value.toString()');
              //   });
              //   f.catchError((e) {
              //     print(e.toString());
              //     return;
              //   });
              // }
            }
          }
        }
      }
    }
  }
}
