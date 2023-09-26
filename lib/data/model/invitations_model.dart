// To parse this JSON data, do
//
//     final invitationsModel = invitationsModelFromJson(jsonString);

import 'dart:convert';

List<InvitationsModel> invitationsModelFromJson(String str) =>
    List<InvitationsModel>.from(
        json.decode(str).map((x) => InvitationsModel.fromJson(x)));

String invitationsModelToJson(List<InvitationsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvitationsModel {
  int id;
  String phoneNumber;
  String email;
  String message;
  bool isAccepted;
  int assignee;
  int groupLamp;

  InvitationsModel({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.message,
    required this.isAccepted,
    required this.assignee,
    required this.groupLamp,
  });

  factory InvitationsModel.fromJson(Map<String, dynamic> json) =>
      InvitationsModel(
        id: json["id"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        message: json["message"],
        isAccepted: json["is_accepted"],
        assignee: json["assignee"],
        groupLamp: json["group_lamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "email": email,
        "message": message,
        "is_accepted": isAccepted,
        "assignee": assignee,
        "group_lamp": groupLamp,
      };
}
