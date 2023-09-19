// To parse this JSON data, do
//
//     final registerVerifyModel = registerVerifyModelFromJson(jsonString);

import 'dart:convert';

RegisterVerifyModel registerVerifyModelFromJson(String str) => RegisterVerifyModel.fromJson(json.decode(str));

String registerVerifyModelToJson(RegisterVerifyModel data) => json.encode(data.toJson());

class RegisterVerifyModel {
    int token;
    String phoneNumber;

    RegisterVerifyModel({
        required this.token,
        required this.phoneNumber,
    });

    factory RegisterVerifyModel.fromJson(Map<String, dynamic> json) => RegisterVerifyModel(
        token: json["token"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "phone_number": phoneNumber,
    };
}
