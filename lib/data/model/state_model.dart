// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  double? id;
  double? internetBoxAssigned;
  double? temperature;
  double? humidity;
  double? light;
  double? airQuality;
  double? lampAssigned;
  int? power;
  String? timestamp;

  StateModel({
    this.id,
    this.internetBoxAssigned,
    this.temperature,
    this.humidity,
    this.light,
    this.airQuality,
    this.lampAssigned,
    this.power,
    this.timestamp,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"],
    internetBoxAssigned: json["internetbox_assigned"] ?? 0.0,
    temperature: json["temperature"] ?? 0.0 ,
    humidity: json["humidity"] ?? 0.0,
    light: json["light"] ?? 0.0,
    airQuality: json["air_quality"] ?? 0.0,
    lampAssigned: json["lamp_assigned"] ?? 0.0,
    power: json["power"] ?? 0.0,
    timestamp: json["timestamp"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "internetbox_assigned": internetBoxAssigned,
    "temperature": temperature,
    "humidity": humidity,
    "light": light,
    "air_quality": airQuality,
    "lamp_assigned": lampAssigned,
    "power": power,
    "timestamp": timestamp,
  };
}
