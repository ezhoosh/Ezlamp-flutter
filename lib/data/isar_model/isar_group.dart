import 'package:easy_lamp/data/isar_model/isar_command.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:easy_lamp/data/isar_model/isar_owner.dart';
import 'package:isar/isar.dart';

part 'isar_group.g.dart';

@collection
class IsarGroup {
  Id idDb = Isar.autoIncrement;
  int? id;
  String? name;
  String? description;

  // List<dynamic> members;
  final owner = IsarLink<IsarOwner>();
  @Backlink(to: 'group')
  final lamps = IsarLinks<IsarLamp>();

  final command = IsarLink<IsarCommand>();

  IsarGroup({this.id, this.name, this.description});
}
