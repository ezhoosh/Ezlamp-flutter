import 'package:easy_lamp/core/utils/isar_repository.dart';
import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:easy_lamp/data/isar_model/isar_lamp.dart';
import 'package:isar/isar.dart';

class IsarLampRepository extends IsarRepository<IsarLamp> {
  IsarLampRepository(super.db);

  @override
  Future<void> save(IsarLamp student) async {
    isar.writeTxnSync(() {
      isar.isarLamps.putSync(student);
    });
  }

  @override
  Future<void> saveAll(List<IsarLamp> t) async {
    isar.writeTxnSync(() {
      isar.isarLamps.putAllSync(t);
    });
  }

  @override
  Future<List<IsarLamp>> getAll() async {
    return await isar.isarLamps.where().findAll();
  }

  @override
  Future<IsarLamp?> getById(IsarLamp group) async {
    return await isar.isarLamps
        .filter()
        .group((q) => q.idDbEqualTo(group.idDb))
        .findFirst();
  }

  Future<List<IsarLamp>> getByGroupId(IsarGroup group) async {
    return await isar.isarLamps
        .filter()
        .group((q) => q.idDbEqualTo(group.idDb))
        .findAll();
  }

  @override
  Future<bool> delete(IsarLamp group) async {
    return await isar.isarLamps.delete(group.idDb);
  }

  @override
  Future<void> clearCollection() async {
    isar.isarLamps.where().deleteAllSync();
  }
}
