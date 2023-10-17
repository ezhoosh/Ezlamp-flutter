// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

List<StateModel> stateModelFromJson(String str) =>
    List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  int id;
  int lampAssigned;
  int white;
  int yellow;
  int red;
  int green;
  int blue;
  int power;
  int light;
  int temperature;
  int humidity;
  int airQuality;
  int co2;
  bool pir;
  DateTime timestamp;

  StateModel({
    required this.id,
    required this.lampAssigned,
    required this.white,
    required this.yellow,
    required this.red,
    required this.green,
    required this.blue,
    required this.power,
    required this.light,
    required this.temperature,
    required this.humidity,
    required this.airQuality,
    required this.co2,
    required this.pir,
    required this.timestamp,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        lampAssigned: json["lamp_assigned"],
        white: json["white"],
        yellow: json["yellow"],
        red: json["red"],
        green: json["green"],
        blue: json["blue"],
        power: json["power"],
        light: json["light"],
        temperature: json["temperature"],
        humidity: json["humidity"],
        airQuality: json["air_quality"],
        co2: json["co2"],
        pir: json["pir"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lamp_assigned": lampAssigned,
        "white": white,
        "yellow": yellow,
        "red": red,
        "green": green,
        "blue": blue,
        "power": power,
        "light": light,
        "temperature": temperature,
        "humidity": humidity,
        "air_quality": airQuality,
        "co2": co2,
        "pir": pir,
        "timestamp": timestamp.toIso8601String(),
      };
}
