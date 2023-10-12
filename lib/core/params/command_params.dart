// To parse this JSON data, do
//
//     final commandParams = commandParamsFromJson(jsonString);

import 'dart:convert';

CommandParams commandParamsFromJson(String str) =>
    CommandParams.fromJson(json.decode(str));


class CommandParams {
  List<int>? lamps;
  int w;
  int y;
  int r;
  int g;
  int b;
  int c;
  bool pir;
  String type;
  int? gid;

  CommandParams({
    this.lamps,
    required this.w,
    required this.y,
    required this.r,
    required this.g,
    required this.b,
    required this.c,
    required this.pir,
    required this.type,
    this.gid,
  });

  factory CommandParams.fromJson(Map<String, dynamic> json) => CommandParams(
        lamps: List<int>.from(json["lamps"].map((x) => x)),
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
}
