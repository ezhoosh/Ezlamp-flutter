part of 'state_bloc.dart';

class StateState {
  BaseStatus getDataStateStatus;

  StateState({
    required this.getDataStateStatus,
  });

  StateState copyWith({BaseStatus? newGetDataStateStatus}) {
    return StateState(
      getDataStateStatus: newGetDataStateStatus ?? getDataStateStatus,
    );
  }
}
