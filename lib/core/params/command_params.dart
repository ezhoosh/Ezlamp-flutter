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
    // if (gid != null || (lamps != null && lamps!.isNotEmpty)) {
    //   List<String> data = [];
    //   lamps?.forEach((element) {
    //     data.add(getBlueCommand(element));
    //   });
    //   return data;
    // } else {
    return getBlueCommand(blueLampId ?? 0);
    // }
  }

  getBlueCommand(int blueLampId) {
    if (isOn == null) {
      return jsonEncode({
        'type': type,
        'uid': lamps.toString(),
        'c': c.toInt(),
        'w': ((w / 100) * s).toInt(),
        'y': ((y / 100) * s).toInt(),
        'r': ((Normalize.normalizeValue(r) / 100) * s).toInt(),
        'g': ((Normalize.normalizeValue(g) / 100) * s).toInt(),
        'b': ((Normalize.normalizeValue(b) / 100) * s).toInt(),
        'pir': pir ? 1 : 0,
      });
    }
    if (isOn!) {
      return jsonEncode({
        'type': type,
        'uid': lamps.toString(),
        'c': 0,
        'w': 50,
        'y': 50,
        'r': 0,
        'g': 0,
        'b': 0,
        'pir': pir ? 1 : 0,
      });
    } else {
      return jsonEncode({
        'type': type,
        'uid': lamps.toString(),
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

  toInternetJson() {
    if (isOn == null) {
      return {
        "w": w,
        "y": y,
        "r": (Normalize.normalizeValue(r) / 100) * s,
        "g": (Normalize.normalizeValue(g) / 100) * s,
        "b": (Normalize.normalizeValue(b) / 100) * s,
        "c": c,
        "is_on": true,
        "pir": true,
        "type": "apply",
        "lamps": lamps,
        "gid": gid.toString(),
      };
    } else {
      if (isOn!) {
        return {
          "w": 50,
          "y": 50,
          "r": 0,
          "g": 0,
          "b": 0,
          "c": c,
          "is_on": true,
          "pir": true,
          "type": "apply",
          "lamps": lamps,
          "gid": gid.toString(),
        };
      } else {
        return {
          "w": 0,
          "y": 0,
          "r": 0,
          "g": 0,
          "b": 0,
          "c": c,
          "pir": true,
          "type": "apply",
          "is_on": false,
          "lamps": lamps,
          "gid": gid.toString(),
        };
      }
    }
  }
}
