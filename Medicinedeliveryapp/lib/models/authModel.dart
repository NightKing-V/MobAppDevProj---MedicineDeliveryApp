import 'package:flutter/foundation.dart';

class AuthModel with ChangeNotifier {
  String _accessToken = '';

  String get accessToken => _accessToken;

  void setToken(String token) {
    _accessToken = token;
    notifyListeners();
  }
}
