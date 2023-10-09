import 'package:easy_lamp/data/isar_model/isar_command.dart';
import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:isar/isar.dart';

part 'isar_lamp.g.dart';

@collection
class IsarLamp {
  Id idDb = Isar.autoIncrement;
  int? id;
  String? name;
  String? description;
  int? owner;
  bool? isActive;
  String? latitude;
  String? longitude;
  String? address;
  int? groupLamp;
  String? mainPower;
  String? lastCommand;
  String? uuid;
  final group = IsarLink<IsarGroup>();
  final command = IsarLink<IsarCommand>();

  IsarLamp(
      {this.id,
      this.name,
      this.description,
      this.owner,
      this.isActive,
      this.latitude,
      this.longitude,
      this.address,
      this.groupLamp,
      this.mainPower,
      this.lastCommand,
      this.uuid});
}
