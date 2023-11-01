// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';

List<ScheduleModel> scheduleModelFromJson(String str) =>
    List<ScheduleModel>.from(
        json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  PeriodicTaskAssigned periodicTaskAssigned;
  PeriodicTaskAssigned periodicTaskOffAssigned;
  CommandModel command;
  int groupAssigned;
  String name;
  bool enabled;

  ScheduleModel({
    required this.periodicTaskAssigned,
    required this.periodicTaskOffAssigned,
    required this.command,
    required this.groupAssigned,
    required this.name,
    required this.enabled,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        periodicTaskAssigned:
            PeriodicTaskAssigned.fromJson(json["periodic_task_assigned"]),
        periodicTaskOffAssigned:
            PeriodicTaskAssigned.fromJson(json["periodic_task_off_assigned"]),
        command: CommandModel.fromJson(json["command"]),
        groupAssigned: json["group_assigned"],
        name: json["name"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "periodic_task_assigned": periodicTaskAssigned.toJson(),
        "periodic_task_off_assigned": periodicTaskOffAssigned.toJson(),
        "command": command.toJson(),
        "group_assigned": groupAssigned,
        "name": name,
        "enabled": enabled,
      };
}

class PeriodicTaskAssigned {
  CrontabModel crontab;
  String name;

  PeriodicTaskAssigned({
    required this.crontab,
    required this.name,
  });

  factory PeriodicTaskAssigned.fromJson(Map<String, dynamic> json) =>
      PeriodicTaskAssigned(
        crontab: CrontabModel.fromJson(json["crontab"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "crontab": crontab.toJson(),
        "name": name,
      };
}
