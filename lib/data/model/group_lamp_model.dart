// To parse this JSON data, do
//
//     final groupLampListModel = groupLampListModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/owner_model.dart';

List<GroupLampModel> groupLampListModelFromJson(String str) =>
    List<GroupLampModel>.from(
        json.decode(str).map((x) => GroupLampModel.fromJson(x)));

String groupLampListModelToJson(List<GroupLampModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupLampModel {
  int id;
  String name;
  String description;
  List<Owner> members;
  Owner owner;
  String groupLamps;

  GroupLampModel({
    required this.id,
    required this.name,
    required this.description,
    required this.members,
    required this.owner,
    required this.groupLamps,
  });

  factory GroupLampModel.fromJson(Map<String, dynamic> json) =>
      GroupLampModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        members:
            List<Owner>.from(json["members"].map((x) => Owner.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        groupLamps: json["group_lamps"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "group_lamps": groupLamps,
      };
}
