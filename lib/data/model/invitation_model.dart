// To parse this JSON data, do
//
//     final invitationModel = invitationModelFromJson(jsonString);

import 'dart:convert';

InvitationModel invitationModelFromJson(String str) =>
    InvitationModel.fromJson(json.decode(str));

String invitationModelToJson(InvitationModel data) =>
    json.encode(data.toJson());

class InvitationModel {
  int id;
  String phoneNumber;
  String message;
  int assignee;
  GroupLamp groupLamp;
  List<Lamp>? lamps;
  bool isOpen = false;

  InvitationModel({
    required this.id,
    required this.phoneNumber,
    required this.message,
    required this.assignee,
    required this.groupLamp,
    required this.lamps,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) =>
      InvitationModel(
        id: json["id"],
        phoneNumber: json["phone_number"],
        message: json["message"],
        assignee: json["assignee"],
        groupLamp: GroupLamp.fromJson(json["group_lamp"]),
        lamps: List<Lamp>.from(json["lamps"].map((x) => Lamp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "message": message,
        "assignee": assignee,
        "group_lamp": groupLamp.toJson(),
        "lamps": lamps != null
            ? List<dynamic>.from(lamps!.map((x) => x.toJson()))
            : '',
      };
}

class GroupLamp {
  int id;
  String name;
  String description;

  GroupLamp({
    required this.id,
    required this.name,
    required this.description,
  });

  factory GroupLamp.fromJson(Map<String, dynamic> json) => GroupLamp(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class Lamp {
  int id;
  String name;
  String description;
  int owner;
  bool isActive;
  String? latitude;
  String? longitude;
  String? address;
  int groupLamp;
  String? mainPower;
  LastCommand? lastCommand;
  String uuid;
  int? internetBox;
  List<int> members;

  Lamp({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.groupLamp,
    required this.mainPower,
    required this.lastCommand,
    required this.uuid,
    required this.internetBox,
    required this.members,
  });

  factory Lamp.fromJson(Map<String, dynamic> json) => Lamp(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        owner: json["owner"],
        isActive: json["is_active"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        groupLamp: json["group_lamp"],
        mainPower: json["main_power"],
        lastCommand: json["last_command"] == null
            ? null
            : LastCommand.fromJson(json["last_command"]),
        uuid: json["uuid"],
        internetBox: json["internet_box"],
        members: List<int>.from(json["members"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "owner": owner,
        "is_active": isActive,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "group_lamp": groupLamp,
        "main_power": mainPower,
        "last_command": lastCommand == null ? null : lastCommand!.toJson(),
        "uuid": uuid,
        "internet_box": internetBox,
        "members": List<dynamic>.from(members.map((x) => x)),
      };
}

class LastCommand {
  String additionalProp1;
  String additionalProp2;
  String additionalProp3;

  LastCommand({
    required this.additionalProp1,
    required this.additionalProp2,
    required this.additionalProp3,
  });

  factory LastCommand.fromJson(Map<String, dynamic> json) => LastCommand(
        additionalProp1: json["additionalProp1"],
        additionalProp2: json["additionalProp2"],
        additionalProp3: json["additionalProp3"],
      );

  Map<String, dynamic> toJson() => {
        "additionalProp1": additionalProp1,
        "additionalProp2": additionalProp2,
        "additionalProp3": additionalProp3,
      };
}
