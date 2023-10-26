// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

List<StateModel> stateModelFromJson(String str) =>
    List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  DateTime timestamp;
  double? power;
  double? temperature;
  double? humidity;
  double? airQuality;
  double? co2;
  double? pir;

  StateModel({
    required this.timestamp,
    required this.power,
    required this.temperature,
    required this.humidity,
    required this.airQuality,
    required this.co2,
    required this.pir,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        timestamp: DateTime.parse(json["timestamp"]),
        power: json["power"]?.toDouble(),
        temperature: json["temperature"]?.toDouble(),
        humidity: json["humidity"]?.toDouble(),
        airQuality: json["air_quality"]?.toDouble(),
        co2: json["co2"]?.toDouble(),
        pir: json["pir"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "power": power,
        "temperature": temperature,
        "humidity": humidity,
        "air_quality": airQuality,
        "co2": co2,
        "pir": pir,
      };
}
