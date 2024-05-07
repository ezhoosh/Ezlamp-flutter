import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_internet_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';

part 'isar_owner.g.dart';

@collection
class IsarOwner {
  Id idDb = kIsWeb ? 1 : Isar.autoIncrement;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;
  @Backlink(to: 'owner')
  final groups = IsarLinks<IsarGroup>();

  @Backlink(to: 'owner')
  final internetBox = IsarLinks<IsarInternetBox>();

  IsarOwner({
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
  });
}
