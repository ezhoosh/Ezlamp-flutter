// To parse this JSON data, do
//
//     final groupLampModel = groupLampModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/data/model/owner_model.dart';

List<GroupModel> groupLampModelFromJson(String str) =>
    List<GroupModel>.from(
        json.decode(str).map((x) => GroupModel.fromJson(x)));

String groupLampModelToJson(List<GroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupModel {
  int id;
  String name;
  String description;
  List<dynamic> members;
  OwnerModel owner;
  List<LampModel> lamps;
  bool open = false;

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.owner,
    required this.lamps,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        members: List<dynamic>.from(json["members"].map((x) => x)),
        owner: OwnerModel.fromJson(json["owner"]),
        lamps: List<LampModel>.from(
            json["lamps"].map((x) => LampModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "members": List<dynamic>.from(members.map((x) => x)),
        "owner": owner.toJson(),
        "lamps": List<dynamic>.from(lamps.map((x) => x)),
      };
}
