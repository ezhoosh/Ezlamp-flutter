part of 'state_bloc.dart';

abstract class StateEvent {}

class GetDataStateEvent extends StateEvent {
  StateParams params;

  GetDataStateEvent(this.params);
}

class GetChartInformation extends StateEvent {
  List<LampModel> lamps;

  GetChartInformation(this.lamps);
}
class GetChartInternetBoxInformation extends StateEvent {
  StateParams params;

  GetChartInternetBoxInformation(this.params);
}
class OnChangeCheckBox extends StateEvent {
  bool isCheckDate;

  OnChangeCheckBox(this.isCheckDate);
}
