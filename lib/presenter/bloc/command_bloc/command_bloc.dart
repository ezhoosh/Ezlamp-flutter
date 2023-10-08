import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/command_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/domain/usecases/send_command_usecase.dart';
import 'package:meta/meta.dart';

part 'command_event.dart';

part 'command_state.dart';

class CommandBloc extends Bloc<CommandEvent, CommandState> {
  SendCommandUseCase sendCommandUseCase;

  CommandBloc(this.sendCommandUseCase)
      : super(CommandState(sendCommandStatus: BaseNoAction())) {
    on<SendCommandEvent>((event, emit) async {
      emit(state.copyWith(newSendCommandStatus: BaseLoading()));
      DataState dataState = await sendCommandUseCase(event.commandParams);
      if (dataState is DataSuccess) {
        emit(state.copyWith(newSendCommandStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newSendCommandStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newSendCommandStatus: BaseNoAction()));
    });
  }
}
