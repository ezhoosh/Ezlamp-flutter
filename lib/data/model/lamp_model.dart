// To parse this JSON data, do
//
//     final lampModel = lampModelFromJson(jsonString);

import 'dart:convert';

List<LampModel> lampModelFromJson(String str) =>
    List<LampModel>.from(json.decode(str).map((x) => LampModel.fromJson(x)));

String lampModelToJson(List<LampModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LampModel {
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
  String? lastCommand;
  String uuid;

  LampModel({
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
  });

  factory LampModel.fromJson(Map<String, dynamic> json) => LampModel(
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
        lastCommand: json["last_command"],
        uuid: json["uuid"],
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
        "last_command": lastCommand,
        "uuid": uuid,
      };
}
