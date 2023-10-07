// To parse this JSON data, do
//
//     final internetBoxModel = internetBoxModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/owner_model.dart';

List<InternetBoxModel> internetBoxModelFromJson(String str) =>
    List<InternetBoxModel>.from(
        json.decode(str).map((x) => InternetBoxModel.fromJson(x)));

String internetBoxModelToJson(List<InternetBoxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InternetBoxModel {
  int id;
  String name;
  String description;
  OwnerModel owner;
  String lamps;

  InternetBoxModel({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.lamps,
  });

  factory InternetBoxModel.fromJson(Map<String, dynamic> json) =>
      InternetBoxModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        owner: OwnerModel.fromJson(json["owner"]),
        lamps: json["lamps"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "owner": owner.toJson(),
        "lamps": lamps,
      };
}
