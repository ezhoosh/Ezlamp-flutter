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
  CommandModel? command;
  PeriodicTaskAssignedParams? periodicTaskAssigned;
  PeriodicTaskAssignedParams? periodicTaskOffAssigned;
  String? name;
  List<int>? groupAssigned;
  int? id;
  bool? enabled;

  UpdateScheduleParams({
    this.periodicTaskAssigned,
    this.command,
    this.periodicTaskOffAssigned,
    this.name,
    this.groupAssigned,
    this.id,
    this.enabled,
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
        if (periodicTaskAssigned != null)
          "periodic_task_assigned": periodicTaskAssigned!.toJson(),
        if (command != null) "command": command!.toJson(),
        if (periodicTaskOffAssigned != null)
          "periodic_task_off_assigned": periodicTaskOffAssigned!.toJson(),
        if (name != null) "name": name,
        if (groupAssigned != null) "group_assigneds": groupAssigned,
        if (enabled != null) 'enabled': enabled,
      };
}
