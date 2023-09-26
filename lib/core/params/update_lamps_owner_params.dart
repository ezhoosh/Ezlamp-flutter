class UpdateLampOwnerParams {
  int lampId;
  int groupLamp;
  bool isActive;
  String name;
  String description;
  String latitude;
  String longitude;
  String address;
  String mainPower;
  Map lastCommand;
  String uuid;
  UpdateLampOwnerParams(
    this.lampId,
    this.groupLamp,
    this.isActive,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.address,
    this.mainPower,
    this.lastCommand,
    this.uuid,
  );
}
