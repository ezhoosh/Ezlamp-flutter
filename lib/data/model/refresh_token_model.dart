// To parse this JSON data, do
//
//     final refreshTokenModel = refreshTokenModelFromJson(jsonString);

import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) => RefreshTokenModel.fromJson(json.decode(str));

String refreshTokenModelToJson(RefreshTokenModel data) => json.encode(data.toJson());

class RefreshTokenModel {
    String access;

    RefreshTokenModel({
        required this.access,
    });

    factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
    };
}
