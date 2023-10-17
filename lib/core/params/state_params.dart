class StateParams {
  int? groupLampId;
  DateTime? timeStamp;
  DateTime? timeStampGte;
  DateTime? timeStampLte;
  bool? isLampOn;

  StateParams({
    this.groupLampId,
    this.timeStamp,
    this.timeStampGte,
    this.timeStampLte,
    this.isLampOn,
  });
}
