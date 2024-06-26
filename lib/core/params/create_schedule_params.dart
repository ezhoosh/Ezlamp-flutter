// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';

CreateScheduleParams scheduleModelFromJson(String str) =>
    CreateScheduleParams.fromJson(json.decode(str));

String scheduleModelToJson(CreateScheduleParams data) =>
    json.encode(data.toJson());

class CreateScheduleParams {
  CommandModel command;
  PeriodicTaskAssignedParams periodicTaskAssigned;
  PeriodicTaskAssignedParams periodicTaskOffAssigned;
  String name;
  List<int> groupAssigned;
  bool enabled;

  CreateScheduleParams({
    required this.periodicTaskAssigned,
    required this.command,
    required this.periodicTaskOffAssigned,
    required this.name,
    required this.groupAssigned,
    required this.enabled,
  });

  factory CreateScheduleParams.fromJson(Map<String, dynamic> json) =>
      CreateScheduleParams(
        periodicTaskAssigned:
            PeriodicTaskAssignedParams.fromJson(json["periodic_task_assigned"]),
        command: CommandModel.fromJson(json["command"]),
        periodicTaskOffAssigned: PeriodicTaskAssignedParams.fromJson(
            json["periodic_task_off_assigned"]),
        name: json["name"],
        groupAssigned: json["group_assigned"],
        enabled: json['enabled'],
      );

  Map<String, dynamic> toJson() => {
        "periodic_task_assigned": periodicTaskAssigned.toJson(),
        "command": command.toJson(),
        "periodic_task_off_assigned": periodicTaskOffAssigned.toJson(),
        "name": name,
        "group_assigneds": groupAssigned,
        'enabled': enabled,
      };
}

class PeriodicTaskAssignedParams {
  CrontabModel crontab;

  PeriodicTaskAssignedParams({
    required this.crontab,
  });

  factory PeriodicTaskAssignedParams.fromJson(Map<String, dynamic> json) =>
      PeriodicTaskAssignedParams(
        crontab: CrontabModel.fromJson(json["crontab"]),
      );

  Map<String, dynamic> toJson() => {
        "crontab": crontab.toJson(),
      };
}
