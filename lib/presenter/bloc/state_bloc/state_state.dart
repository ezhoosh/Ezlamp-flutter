part of 'state_bloc.dart';

class StateState {
  BaseStatus getDataStateStatus;
  BaseStatus getChartInformation;
  bool isCheckDate = false;
  bool isEnableDatePicker = true;

  StateState({
    required this.getDataStateStatus,
    required this.getChartInformation,
    required this.isCheckDate,
    required this.isEnableDatePicker
  });

  StateState copyWith({
    BaseStatus? newGetDataStateStatus,
    BaseStatus? newGetChartInformation,
    bool? newIsCheckDate,
    bool? newIsEnableDatePicker
  }) {
    return StateState(
      getDataStateStatus: newGetDataStateStatus ?? getDataStateStatus,
      getChartInformation: newGetChartInformation ?? getChartInformation,
      isCheckDate: newIsCheckDate ?? isCheckDate,
      isEnableDatePicker: newIsEnableDatePicker ?? isEnableDatePicker
    );
  }
}
