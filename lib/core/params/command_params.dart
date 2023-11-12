// To parse this JSON data, do
//
//     final commandParams = commandParamsFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/core/utils/normalize.dart';

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
  int? blueLampId;

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
    this.blueLampId,
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

  String toBlueJson() {
    return jsonEncode({
      'type': type,
      'uid': blueLampId.toString().padLeft(6, '0'),
      'w': w,
      'y': y,
      'r': Normalize.normalizeValue(r),
      'g': Normalize.normalizeValue(g),
      'b': Normalize.normalizeValue(b),
      'c': c,
      'pir': pir ? 1 : 0,
    });
  }
}
