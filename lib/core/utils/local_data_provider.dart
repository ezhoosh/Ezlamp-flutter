import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  final SharedPreferences _storage;

  LocalDataProvider(this._storage);

  Future<dynamic> readStorage(String key) async {
    String? value = await _storage.getString(key);
    return value ?? "";
  }

  Future<dynamic> deleteStorage(String key) async {
    await _storage.remove(key);
    return;
  }

  Future<dynamic> writeStorage(String key, String value) async {
    await _storage.setString(key, value);
    return;
  }

  Future<dynamic> deleteAllStorage() async {
    await _storage.clear();
    return;
  }
}
