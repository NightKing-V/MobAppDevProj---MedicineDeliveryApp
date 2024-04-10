import 'package:flutter/foundation.dart';

class AuthModel with ChangeNotifier {
  DateTime? _loginTime;
  String _accessToken = '';
  String _username = '';

  String get accessToken => _accessToken;
  String get username => _username;

  void setToken(String token,String name) {
    _loginTime = DateTime.now();
    _accessToken = token;
    _username = name;
    notifyListeners();
  }

  void logout() {
    _accessToken = "";
    _loginTime = null; // Explicitly set loginTime to null on logout
    notifyListeners();
  }

  DateTime? get loginTime => _loginTime;

  bool get isSessionExpired {
    if (_loginTime == null) return false;
    return DateTime.now().difference(_loginTime!).inMinutes >
        1; // Check for 30 minutes
  }
}
