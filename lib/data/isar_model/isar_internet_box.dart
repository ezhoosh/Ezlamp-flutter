// To parse this JSON data, do
//
//     final internetBoxModel = internetBoxModelFromJson(jsonString);

import 'dart:convert';

import 'package:easy_lamp/data/isar_model/isar_owner.dart';
import 'package:easy_lamp/data/model/owner_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';

part 'isar_internet_box.g.dart';

@collection
class IsarInternetBox {
  Id idDb = kIsWeb ? 1 : Isar.autoIncrement;
  int? id;
  String? name;
  String? description;
  final owner = IsarLink<IsarOwner>();

  // OwnerModel? owner;

  // List<dynamic> lamps;

  IsarInternetBox({
    this.id,
    this.name,
    this.description,
    // this.owner,
    // this.lamps,
  });
}
