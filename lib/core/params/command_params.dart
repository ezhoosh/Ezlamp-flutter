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
  int s;
  bool pir;
  String type;
  bool? isOn;
  int? gid;
  int? blueLampId;

  CommandParams({
    this.lamps,
    this.w = 0,
    this.y = 0,
    this.r = 0,
    this.g = 0,
    this.b = 0,
    this.c = 0,
    this.s = 0,
    this.isOn,
    this.pir = true,
    this.type = '',
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
        s: 100,
        pir: json["pir"],
        type: json["type"],
        gid: json["gid"],
      );

  toBlueJson() {
    if (isOn == null) {
      if (gid != null) {
        List<String> data = [];
        lamps?.forEach((element) {
          data.add(jsonEncode({
            'type': type,
            'uid': element.toString().padLeft(6, '0'),
            'c': c.toInt(),
            'w': ((w / 100) * s).toInt(),
            'y': ((y / 100) * s).toInt(),
            'r': ((Normalize.normalizeValue(r) / 100) * s).toInt(),
            'g': ((Normalize.normalizeValue(g) / 100) * s).toInt(),
            'b': ((Normalize.normalizeValue(b) / 100) * s).toInt(),
            'pir': pir ? 1 : 0,
          }));
        });
        return data;
      } else {
        return jsonEncode({
          'type': type,
          'uid': blueLampId.toString().padLeft(6, '0'),
          'c': c.toInt(),
          'w': ((w / 100) * s).toInt(),
          'y': ((y / 100) * s).toInt(),
          'r': ((Normalize.normalizeValue(r) / 100) * s).toInt(),
          'g': ((Normalize.normalizeValue(g) / 100) * s).toInt(),
          'b': ((Normalize.normalizeValue(b) / 100) * s).toInt(),
          'pir': pir ? 1 : 0,
        });
      }
    } else {
      if (isOn!) {
        return jsonEncode({
          'type': type,
          'uid': blueLampId.toString().padLeft(6, '0'),
          'c': 0,
          'w': 50,
          'y': 50,
          'r': 0,
          'g': 0,
          'b': 0,
          'pir': pir ? 1 : 0,
        });
      } else {
        // [  +15 ms] I/flutter (13957): send single: {"type":"","uid":"000003","c":0,"w":0,"y":0,"r":0,"g":0,"b":0,"pir":0}
        return jsonEncode({
          'type': type,
          'uid': blueLampId.toString().padLeft(6, '0'),
          'c': 0,
          'w': 0,
          'y': 0,
          'r': 0,
          'g': 0,
          'b': 0,
          'pir': 0,
        });
      }
    }
  }

  toInternetJson() {
    if (isOn == null) {
      return jsonEncode({
        "w": w,
        "y": y,
        "r": (Normalize.normalizeValue(r) / 100) * s,
        "g": (Normalize.normalizeValue(g) / 100) * s,
        "b": (Normalize.normalizeValue(b) / 100) * s,
        "c": c,
        "pir": true,
        "type": "apply",
        if (lamps != null) "lamps": lamps,
        if (gid != null) "gid": gid.toString(),
      });
    } else {
      if (isOn!) {
        return jsonEncode({
          "w": 50,
          "y": 50,
          "r": 0,
          "g": 0,
          "b": 0,
          "c": c,
          "pir": true,
          "type": "apply",
          if (lamps != null) "lamps": lamps,
          if (gid != null) "gid": gid.toString(),
        });
      } else {
        return jsonEncode({
          "w": 0,
          "y": 0,
          "r": 0,
          "g": 0,
          "b": 0,
          "c": c,
          "pir": true,
          "type": "apply",
          if (lamps != null) "lamps": lamps,
          if (gid != null) "gid": gid.toString(),
        });
      }
    }
  }
}
