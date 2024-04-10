import 'package:flutter/foundation.dart';

class AuthModel with ChangeNotifier {
  String _accessToken = '';
  String _username = '';

  String get accessToken => _accessToken;
  String get username => _username;

  void setToken(String token,String name) {
    _accessToken = token;
    _username = name;
    notifyListeners();
  }
}
