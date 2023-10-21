// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

List<ScheduleModel> scheduleModelFromJson(String str) =>
    List<ScheduleModel>.from(
        json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  int id;
  PeriodicTaskAssigned periodicTaskAssigned;
  int groupAssigned;

  ScheduleModel({
    required this.id,
    required this.periodicTaskAssigned,
    required this.groupAssigned,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        periodicTaskAssigned:
            PeriodicTaskAssigned.fromJson(json["periodic_task_assigned"]),
        groupAssigned: json["group_assigned"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "periodic_task_assigned": periodicTaskAssigned.toJson(),
        "group_assigned": groupAssigned,
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
