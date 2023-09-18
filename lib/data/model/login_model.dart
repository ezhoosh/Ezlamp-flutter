// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String phoneNumber;
  String refresh;
  String access;

  LoginModel({
    required this.phoneNumber,
    required this.refresh,
    required this.access,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        phoneNumber: json["phone_number"],
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "refresh": refresh,
        "access": access,
      };
}
