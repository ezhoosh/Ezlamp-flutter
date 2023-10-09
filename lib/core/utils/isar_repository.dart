import 'package:isar/isar.dart';

abstract class IsarRepository<T> {
  late Isar isar;

  IsarRepository(this.isar);

  Future<void> cleanDb() async {
    await isar.writeTxn(() => isar.clear());
  }

  Future<void> save(T t);

  Future<void> saveAll(List<T> t);

  Future<List<T>> getAll();

  Future<List<T>> getById(T t);

  Future<bool> delete(T t);

  Future<void> clearCollection();
}
