import 'dart:async';
import 'dart:convert';

import 'package:easy_lamp/core/resource/constants.dart';
import 'package:easy_lamp/data/model/login_model.dart';
import 'package:easy_lamp/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStorage {
  static AuthTokenStorage? _instance;

  final StreamController<LoginModel?> _streamController;

  static AuthTokenStorage get instance => _instance ??= AuthTokenStorage._();

  AuthTokenStorage._() : _streamController = StreamController.broadcast();

  Future<void> save(LoginModel authInfo) async {
    String user = jsonEncode(authInfo);
    locator<SharedPreferences>()
        .setString(Constants.user, user);
    _streamController.add(authInfo);
    return;
  }

  Future<LoginModel?> load() async {
    var authInfo = locator<SharedPreferences>().getString(Constants.user);
    if (authInfo == null) {
      return null;
    }
    if (authInfo.isEmpty) {
      return null;
    }
    Map<String, dynamic> userMap = jsonDecode(authInfo);
    var user = LoginModel.fromJson(userMap);
    return user;
  }

  Future<void> delete() async {
    (locator<SharedPreferences>().remove(Constants.user));
    _streamController.add(null);
  }

  Stream<LoginModel?> watch() => _streamController.stream;
}
