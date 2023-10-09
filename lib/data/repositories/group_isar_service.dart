import 'package:easy_lamp/core/utils/isar_repository.dart';
import 'package:easy_lamp/data/isar_model/isar_group.dart';
import 'package:isar/isar.dart';

class IsarGroupRepository extends IsarRepository<IsarGroup> {
  IsarGroupRepository(super.db);

  @override
  Future<void> save(IsarGroup student) async {
    isar.writeTxnSync(() {
      isar.isarGroups.putSync(student);
    });
  }

  @override
  Future<void> saveAll(List<IsarGroup> t) async {
    isar.writeTxnSync(() {
      isar.isarGroups.putAllSync(t);
    });
  }

  @override
  Future<List<IsarGroup>> getAll() async {
    return await isar.isarGroups.where().findAll();
  }

  @override
  Future<List<IsarGroup>> getById(IsarGroup group) async {
    return await isar.isarGroups
        .filter()
        .group((q) => q.idDbEqualTo(group.idDb))
        .findAll();
  }

  @override
  Future<bool> delete(IsarGroup group) async {
    return await isar.isarGroups.delete(group.idDb);
  }

  @override
  Future<void> clearCollection() async {
    isar.isarGroups.where().deleteAllSync();
  }
}
