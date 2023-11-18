part of 'state_bloc.dart';

class StateState {
  BaseStatus getDataStateStatus;
  BaseStatus getChartInformation;

  StateState({
    required this.getDataStateStatus,
    required this.getChartInformation,
  });

  StateState copyWith({
    BaseStatus? newGetDataStateStatus,
    BaseStatus? newGetChartInformation,
  }) {
    return StateState(
      getDataStateStatus: newGetDataStateStatus ?? getDataStateStatus,
      getChartInformation: newGetChartInformation ?? getChartInformation,
    );
  }
}
