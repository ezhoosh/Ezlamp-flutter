class StateParams {
  String whichParam;
  int? groupLampId;
  String? lamps;
  DateTime? timeStamp;
  DateTime? timeStampGte;
  DateTime? timeStampLte;
  bool? isLampOn;

  StateParams(
    this.whichParam, {
    this.groupLampId,
    this.timeStamp,
    this.timeStampGte,
    this.timeStampLte,
    this.isLampOn,
    this.lamps,
  });
}
