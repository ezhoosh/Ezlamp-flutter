import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:isar/isar.dart';

part 'isar_command.g.dart';

@collection
class IsarCommand {
  Id idDb=Isar.autoIncrement;
  List<int>? lampsIds;
  int? w;
  int? y;
  int? r;
  int? g;
  int? b;
  int? c;
  bool? pir;
  String? type;
  int? gid;
  @Backlink(to: 'command')
  final lamp = IsarLinks<IsarLamp>();
  @Backlink(to: 'command')
  final groups = IsarLinks<IsarGroup>();

  IsarCommand({
    this.lampsIds,
    this.w,
    this.y,
    this.r,
    this.g,
    this.b,
    this.c,
    this.pir,
    this.type,
    this.gid,
  });
}
