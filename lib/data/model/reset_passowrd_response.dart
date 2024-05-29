// To parse this JSON data, do
//
//     final sendLoginOtpModel = sendLoginOtpModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordResponse resetPasswordResponseFromJson(String str) =>
    ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) =>
    json.encode(data.toJson());

class ResetPasswordResponse {
  String phoneNumber;

  ResetPasswordResponse({
    required this.phoneNumber,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponse(
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
      };
}
