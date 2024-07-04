// To parse this JSON data, do
//
//     final commandModel = commandModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/core/utils/normalize.dart';

CommandModel commandModelFromJson(String str) =>
    CommandModel.fromJson(json.decode(str));

String commandModelToJson(CommandModel data) => json.encode(data.toJson());

class CommandModel {
  List<int>? lamps;
  int w;
  int y;
  int r;
  int g;
  int b;
  int c;
  int s;
  bool? pir;
  String? type;
  int? gid;

  CommandModel({
    required this.lamps,
    required this.w,
    required this.y,
    required this.r,
    required this.g,
    required this.b,
    required this.c,
    required this.pir,
    required this.type,
    required this.gid,
    required this.s
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) => CommandModel(
        lamps: json.containsKey('lamps')
            ? List<int>.from(json["lamps"].map((x) => x))
            : [],
        w: json["w"] ?? 0,
        y: json["y"] ?? 0,
        r: json["r"] ?? 0,
        g: json["g"] ?? 0,
        b: json["b"] ?? 0,
        c: json["c"] ?? 0,
        s: 100,
        pir: json["pir"],
        type: json["type"],
        gid: json["gid"],
      );

  Map<String, dynamic> toJson() {
    return {
      if (lamps != null) "lamps": List<dynamic>.from(lamps!.map((x) => x)),
      'c': c.toInt(),
      'w': ((w / 100) * s).toInt(),
      'y': ((y / 100) * s).toInt(),
      'r': ((Normalize.normalizeValue(r) / 100) * s).toInt(),
      'g': ((Normalize.normalizeValue(g) / 100) * s).toInt(),
      'b': ((Normalize.normalizeValue(b) / 100) * s).toInt(),
      'pir': pir! ? 1 : 0,
      'type': type,
      if (gid != null) "gid": gid,
    };
  }
}
