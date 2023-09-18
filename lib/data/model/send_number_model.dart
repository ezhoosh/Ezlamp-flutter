// To parse this JSON data, do
//
//     final sendNumberModel = sendNumberModelFromJson(jsonString);

import 'dart:convert';

SendNumberModel sendNumberModelFromJson(String str) =>
    SendNumberModel.fromJson(json.decode(str));

String sendNumberModelToJson(SendNumberModel data) =>
    json.encode(data.toJson());

class SendNumberModel {
  String phoneNumber;
  bool exist;

  SendNumberModel({
    required this.phoneNumber,
    required this.exist,
  });

  factory SendNumberModel.fromJson(Map<String, dynamic> json) =>
      SendNumberModel(
        phoneNumber: json["phone_number"],
        exist: json["exist"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "exist": exist,
      };
}
