import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_lamp/core/params/state_params.dart';
import 'package:easy_lamp/core/params/user_params.dart';
import 'package:easy_lamp/core/resource/base_status.dart';
import 'package:easy_lamp/core/resource/data_state.dart';
import 'package:easy_lamp/core/resource/use_case.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/domain/usecases/get_data_state_internet_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_data_state_usecase.dart';
import 'package:easy_lamp/domain/usecases/get_user_usecase.dart';
import 'package:easy_lamp/domain/usecases/update_user_usecase.dart';

part 'state_event.dart';

part 'state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  GetDataStateUseCase getUserUseCase;
  GetDataStateInternetUseCase getDataStateInternetUseCase;

  StateBloc(
    this.getUserUseCase,
      this.getDataStateInternetUseCase
  ) : super(
          StateState(
            getDataStateStatus: BaseNoAction(),
            getChartInformation: BaseNoAction(),
            isCheckDate: false,
            isEnableDatePicker: true
          ),
        ) {
    on<GetChartInformation>((event, emit) async {
      emit(state.copyWith(newGetChartInformation: BaseSuccess(event.lamps)));
    });
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
    on<OnChangeCheckBox>(_onChangeCheckBox);
    on<GetChartInternetBoxInformation>(_getDataStateInternetEvent);
  }
  _onChangeCheckBox(OnChangeCheckBox event, Emitter<StateState> emit) {
    emit(state.copyWith(newIsCheckDate: event.isCheckDate));
    emit(state.copyWith(newIsEnableDatePicker: !event.isCheckDate));
  }
  _getDataStateInternetEvent(GetChartInternetBoxInformation event, Emitter<StateState> emit) async {
    emit(state.copyWith(newGetDataStateStatus: BaseLoading()));
    DataState dataState = await getDataStateInternetUseCase(event.params);
    if (dataState is DataSuccess) {
      emit(
          state.copyWith(newGetDataStateStatus: BaseSuccess(dataState.data)));
    } else if(dataState is DataFailed){
      emit(state.copyWith(newGetDataStateStatus: BaseError(dataState.error)));
    }else {
      emit(state.copyWith(newGetDataStateStatus: BaseNoAction()));
    }
  }
}
