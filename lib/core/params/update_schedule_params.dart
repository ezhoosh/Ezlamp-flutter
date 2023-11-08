// To parse this JSON data, do
//
//     final updateScheduleParams = updateScheduleParamsFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/core/params/create_schedule_params.dart';
import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';

UpdateScheduleParams updateScheduleParamsFromJson(String str) =>
    UpdateScheduleParams.fromJson(json.decode(str));

String updateScheduleParamsToJson(UpdateScheduleParams data) =>
    json.encode(data.toJson());

class UpdateScheduleParams {
  CommandModel command;
  PeriodicTaskAssignedParams periodicTaskAssigned;
  PeriodicTaskAssignedParams periodicTaskOffAssigned;
  String name;
  List<int> groupAssigned;
  int? id;
  bool enabled;

  UpdateScheduleParams({
    required this.periodicTaskAssigned,
    required this.command,
    required this.periodicTaskOffAssigned,
    required this.name,
    required this.groupAssigned,
    this.id,
    required this.enabled,
  });

  factory UpdateScheduleParams.fromJson(Map<String, dynamic> json) =>
      UpdateScheduleParams(
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
