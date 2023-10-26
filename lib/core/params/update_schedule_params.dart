// To parse this JSON data, do
//
//     final updateScheduleParams = updateScheduleParamsFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/model/command_model.dart';
import 'package:easy_lamp/data/model/crontab_model.dart';

UpdateScheduleParams updateScheduleParamsFromJson(String str) =>
    UpdateScheduleParams.fromJson(json.decode(str));

String updateScheduleParamsToJson(UpdateScheduleParams data) =>
    json.encode(data.toJson());

class UpdateScheduleParams {
  int? id;
  CrontabModel periodicTaskAssigned;
  CrontabModel periodicTaskOffAssigned;
  CommandModel command;
  int groupAssigned;
  bool oneOff;
  String name;

  UpdateScheduleParams({
    required this.periodicTaskAssigned,
    required this.periodicTaskOffAssigned,
    required this.command,
    required this.groupAssigned,
    required this.oneOff,
    required this.name,
  });

  factory UpdateScheduleParams.fromJson(Map<String, dynamic> json) =>
      UpdateScheduleParams(
          periodicTaskAssigned:
              CrontabModel.fromJson(json["periodic_task_assigned"]),
          periodicTaskOffAssigned:
              CrontabModel.fromJson(json["periodic_task_off_assigned"]),
          command: CommandModel.fromJson(json["command"]),
          groupAssigned: json["group_assigned"],
          oneOff: json['one_off'],
          name: json["name"]);

  Map<String, dynamic> toJson() => {
        "periodic_task_assigned": periodicTaskAssigned.toJson(),
        "periodic_task_off_assigned": periodicTaskOffAssigned.toJson(),
        "command": command.toJson(),
        "group_assigned": groupAssigned,
        "name": name,
        "off_one": oneOff,
      };
}
