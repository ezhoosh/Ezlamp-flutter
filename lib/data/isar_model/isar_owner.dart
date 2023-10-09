import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:isar/isar.dart';

part 'isar_owner.g.dart';

@collection
class IsarOwner {
  Id idDb = Isar.autoIncrement;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;
  @Backlink(to: 'owner')
  final groups = IsarLinks<IsarGroup>();

  IsarOwner({
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
  });
}
