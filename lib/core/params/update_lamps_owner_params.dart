class UpdateLampOwnerParams {
  int groupLamp;
  String name;
  String description;
  String uuid;
  int? internetBox;

  UpdateLampOwnerParams(this.groupLamp, this.name, this.description, this.uuid,
      {this.internetBox});
}
