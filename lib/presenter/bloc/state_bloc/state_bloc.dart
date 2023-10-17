import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/domain/usecases/get_data_state_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_user_usecase.dart';

part 'state_event.dart';

part 'state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  GetDataStateUseCase getUserUseCase;

  StateBloc(
    this.getUserUseCase,
  ) : super(
          StateState(
            getDataStateStatus: BaseNoAction(),
          ),
        ) {
    on<GetDataStateEvent>((event, emit) async {
      emit(state.copyWith(newGetDataStateStatus: BaseLoading()));
      DataState dataState = await getUserUseCase(event.params);
      if (dataState is DataSuccess) {
        emit(
            state.copyWith(newGetDataStateStatus: BaseSuccess(dataState.data)));
      } else {
        emit(state.copyWith(newGetDataStateStatus: BaseError(dataState.error)));
      }
      emit(state.copyWith(newGetDataStateStatus: BaseNoAction()));
    });
  }
}
