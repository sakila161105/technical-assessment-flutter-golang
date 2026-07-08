import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  String _token = "";

  String get token => _token;

  String _name = "";

  String get name => _name;

  Future<bool> login(String email, String password) async {
    _loading = true;

    notifyListeners();

    try {
      final response = await ApiService.login(email, password);

      if (response["token"] != null) {
        _token = response["token"] ?? "";

        _name = response["user"]?["name"] ?? "";

        _isLogin = true;

        _loading = false;

        notifyListeners();

        return true;
      }

      _loading = false;

      notifyListeners();

      return false;
    } catch (e) {
      _loading = false;

      notifyListeners();

      return false;
    }
  }

  void logout() {
    _token = "";

    _name = "";

    _isLogin = false;

    notifyListeners();
  }
}
