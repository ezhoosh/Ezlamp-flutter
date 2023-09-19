// To parse this JSON data, do
//
//     final sendLoginOtpModel = sendLoginOtpModelFromJson(jsonString);

import 'dart:convert';

SendLoginOtpModel sendLoginOtpModelFromJson(String str) =>
    SendLoginOtpModel.fromJson(json.decode(str));

String sendLoginOtpModelToJson(SendLoginOtpModel data) =>
    json.encode(data.toJson());

class SendLoginOtpModel {
  String phoneNumber;

  SendLoginOtpModel({
    required this.phoneNumber,
  });

  factory SendLoginOtpModel.fromJson(Map<String, dynamic> json) =>
      SendLoginOtpModel(
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
      };
}
