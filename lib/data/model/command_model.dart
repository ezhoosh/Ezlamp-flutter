// To parse this JSON data, do
//
//     final commandModel = commandModelFromJson(jsonString);

import 'dart:convert';

CommandModel commandModelFromJson(String str) =>
    CommandModel.fromJson(json.decode(str));

String commandModelToJson(CommandModel data) => json.encode(data.toJson());

class CommandModel {
  List<int>? lamps;
  int? w;
  int? y;
  int? r;
  int? g;
  int? b;
  int? c;
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
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) => CommandModel(
        lamps: json.containsKey('lamps')
            ? List<int>.from(json["lamps"].map((x) => x))
            : [],
        w: json["w"],
        y: json["y"],
        r: json["r"],
        g: json["g"],
        b: json["b"],
        c: json["c"],
        pir: json["pir"],
        type: json["type"],
        gid: json["gid"],
      );

  Map<String, dynamic> toJson() => {
        if (lamps != null) "lamps": List<dynamic>.from(lamps!.map((x) => x)),
        "w": w,
        "y": y,
        "r": r,
        "g": g,
        "b": b,
        "c": c,
        "pir": pir,
        "type": type,
        if (gid != null) "gid": gid,
      };
}
