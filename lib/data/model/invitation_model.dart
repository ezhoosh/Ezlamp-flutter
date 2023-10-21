// To parse this JSON data, do
//
//     final invitationModel = invitationModelFromJson(jsonString);

import 'dart:convert';

List<InvitationModel> invitationModelFromJson(String str) =>
    List<InvitationModel>.from(
        json.decode(str).map((x) => InvitationModel.fromJson(x)));

String invitationModelToJson(List<InvitationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvitationModel {
  int id;
  String phoneNumber;
  String message;
  int assignee;
  int groupLamp;
  List<int> lamps;

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
        groupLamp: json["group_lamp"],
        lamps: List<int>.from(json["lamps"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "message": message,
        "assignee": assignee,
        "group_lamp": groupLamp,
        "lamps": List<dynamic>.from(lamps.map((x) => x)),
      };
}
