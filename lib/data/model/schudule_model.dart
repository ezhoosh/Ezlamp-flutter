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
  CrontabModel periodicTaskAssigned;
  CrontabModel periodicTaskOffAssigned;
  CommandModel command;
  int groupAssigned;
  bool oneOff;
  String name;

  ScheduleModel({
    required this.periodicTaskAssigned,
    required this.periodicTaskOffAssigned,
    required this.command,
    required this.groupAssigned,
    required this.oneOff,
    required this.name,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
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
