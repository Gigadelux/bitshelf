import 'package:bitshelf/data/models/User.dart';
import 'package:hashlib/hashlib.dart' as hashlib;

import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static final user = User.empty();

  static Future<void> login(String username, String password) async {
    user.passwordHash = hashlib.sha3_256sum(password);
    user.username = username;
    _instance.notifyListeners();
  }

  static Future<void> logout() async {
    user.passwordHash = "";
    user.username = "";
    _instance.notifyListeners();
  }
}