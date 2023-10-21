// To parse this JSON data, do
//
//     final createScheduleParams = createScheduleParamsFromJson(jsonString);

import 'dart:convert';

CreateScheduleParams createScheduleParamsFromJson(String str) =>
    CreateScheduleParams.fromJson(json.decode(str));

String createScheduleParamsToJson(CreateScheduleParams data) =>
    json.encode(data.toJson());

class CreateScheduleParams {
  PeriodicTaskAssigned periodicTaskAssigned;
  Command command;
  int groupAssigned;

  CreateScheduleParams({
    required this.periodicTaskAssigned,
    required this.command,
    required this.groupAssigned,
  });

  factory CreateScheduleParams.fromJson(Map<String, dynamic> json) =>
      CreateScheduleParams(
        periodicTaskAssigned:
            PeriodicTaskAssigned.fromJson(json["periodic_task_assigned"]),
        command: Command.fromJson(json["command"]),
        groupAssigned: json["group_assigned"],
      );

  Map<String, dynamic> toJson() => {
        "periodic_task_assigned": periodicTaskAssigned.toJson(),
        "command": command.toJson(),
        "group_assigned": groupAssigned,
      };
}

class Command {
  List<dynamic> lamps;
  int w;
  int y;
  int r;
  int g;
  int b;
  int c;
  bool pir;
  String type;
  int gid;

  Command({
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

  factory Command.fromJson(Map<String, dynamic> json) => Command(
        lamps: List<dynamic>.from(json["lamps"].map((x) => x)),
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
        "lamps": List<dynamic>.from(lamps.map((x) => x)),
        "w": w,
        "y": y,
        "r": r,
        "g": g,
        "b": b,
        "c": c,
        "pir": pir,
        "type": type,
        "gid": gid,
      };
}

class PeriodicTaskAssigned {
  Crontab crontab;
  bool enabled;
  bool oneOff;
  String name;

  PeriodicTaskAssigned({
    required this.crontab,
    required this.enabled,
    required this.oneOff,
    required this.name,
  });

  factory PeriodicTaskAssigned.fromJson(Map<String, dynamic> json) =>
      PeriodicTaskAssigned(
        crontab: Crontab.fromJson(json["crontab"]),
        enabled: json["enabled"],
        oneOff: json["one_off"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "crontab": crontab.toJson(),
        "enabled": enabled,
        "one_off": oneOff,
        "name": name,
      };
}

class Crontab {
  String minute;
  String hour;
  String dayOfWeek;
  String dayOfMonth;
  String monthOfYear;

  Crontab({
    required this.minute,
    required this.hour,
    required this.dayOfWeek,
    required this.dayOfMonth,
    required this.monthOfYear,
  });

  factory Crontab.fromJson(Map<String, dynamic> json) => Crontab(
        minute: json["minute"],
        hour: json["hour"],
        dayOfWeek: json["day_of_week"],
        dayOfMonth: json["day_of_month"],
        monthOfYear: json["month_of_year"],
      );

  Map<String, dynamic> toJson() => {
        "minute": minute,
        "hour": hour,
        "day_of_week": dayOfWeek,
        "day_of_month": dayOfMonth,
        "month_of_year": monthOfYear,
      };
}
