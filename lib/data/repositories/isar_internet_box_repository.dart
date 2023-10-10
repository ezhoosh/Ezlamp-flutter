import 'package:easy_lamp/core/utils/isar_repository.dart';
import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_internet_box.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:isar/isar.dart';

class IsarInternetBoxRepository extends IsarRepository<IsarInternetBox> {
  IsarInternetBoxRepository(super.db);

  @override
  Future<void> save(IsarInternetBox t) async {
    isar.writeTxnSync(() {
      isar.isarInternetBoxs.putSync(t);
    });
  }

  @override
  Future<void> saveAll(List<IsarInternetBox> t) async {
    isar.writeTxnSync(() {
      isar.isarInternetBoxs.where().deleteAllSync();
      isar.isarInternetBoxs.putAllSync(t);
    });
  }

  @override
  Future<List<IsarInternetBox>> getAll() async {
    return await isar.isarInternetBoxs.where().findAll();
  }

  @override
  Future<IsarInternetBox?> getById(IsarInternetBox t) async {
    return await isar.isarInternetBoxs
        .filter()
        .group((q) => q.idDbEqualTo(t.idDb))
        .findFirst();
  }

  @override
  Future<bool> delete(IsarInternetBox t) async {
    return await isar.isarInternetBoxs.delete(t.idDb);
  }

  @override
  Future<void> clearCollection() async {
    isar.isarInternetBoxs.where().deleteAllSync();
  }
}
