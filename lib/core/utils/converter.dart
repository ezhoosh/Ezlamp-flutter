import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_internet_box.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:easy_lamp/data/isar_model/isar_owner.dart';
import 'package:easy_lamp/data/model/group_lamp_model.dart';
import 'package:easy_lamp/data/model/internet_box_model.dart';
import 'package:easy_lamp/data/model/lamp_model.dart';
import 'package:easy_lamp/data/model/owner_model.dart';
import 'package:isar/isar.dart';

class Converter {
  static List<IsarGroup> groupLampModelToIsarGroup(List<GroupModel> data) {
    return data
        .map(
          (e) => IsarGroup(
            id: e.id,
            name: e.name,
            description: e.description,
          )
            ..lamps.addAll(e.lamps
                .map((e) => IsarLamp(
                      id: e.id,
                      name: e.name,
                      description: e.description,
                      latitude: e.latitude,
                      longitude: e.longitude,
                      isActive: e.isActive,
                      address: e.address,
                      groupLamp: e.groupLamp,
                      uuid: e.uuid,
                      mainPower: e.mainPower,
                      owner: e.owner,
                    ))
                .toList())
            ..owner.value = IsarOwner(
              phoneNumber: e.owner.phoneNumber,
              firstName: e.owner.firstName,
              lastName: e.owner.lastName,
              email: e.owner.email,
            ),
        )
        .toList();
  }

  static Future<List<GroupModel>> isarGroupToGroupLampModel(
      List<IsarGroup> data) async {
    return data.map((e) {
      IsarOwner? owner = e.owner.value;
      // List<IsarLamp> lamps = await e.lamps.filter().findAll();
      return GroupModel(
        id: e.id ?? 0,
        name: e.name ?? '',
        description: e.description ?? '',
        members: [],
        owner: OwnerModel(
          phoneNumber: owner?.phoneNumber ?? '',
          firstName: owner?.firstName ?? '',
          lastName: owner?.lastName ?? '',
          email: owner?.email ?? '',
        ),
        lamps: [],
      );
    }).toList();
  }

  static List<LampModel> isarLampToLampModel(List<IsarLamp> data) {
    return data
        .map((e) => LampModel(
            id: e.id ?? 0,
            name: e.name ?? '',
            description: e.description ?? '',
            owner: e.owner ?? 0,
            isActive: e.isActive ?? false,
            latitude: e.latitude ?? "",
            longitude: e.longitude ?? "",
            address: e.address ?? "",
            groupLamp: e.groupLamp ?? 0,
            mainPower: e.mainPower ?? '',
            uuid: e.uuid ?? ''))
        .toList();
  }

  static List<InternetBoxModel> isarInternetBoxToInternetBoxModel(
      List<IsarInternetBox> data) {
    return data
        .map((e) => InternetBoxModel(
            id: e.id ?? 0,
            name: e.name ?? '',
            description: e.description ?? '',
            owner: null,
            lamps: []))
        .toList();
  }

  static List<IsarInternetBox> internetBoxModelToIsarInternetBox(
      List<InternetBoxModel> data) {
    return data
        .map((e) => IsarInternetBox(
              id: e.id,
              name: e.name,
              description: e.description,
            )..owner.value = IsarOwner(
                phoneNumber: e.owner!.phoneNumber,
                firstName: e.owner!.firstName,
                lastName: e.owner!.lastName,
                email: e.owner!.email,
              ))
        .toList();
  }
}
