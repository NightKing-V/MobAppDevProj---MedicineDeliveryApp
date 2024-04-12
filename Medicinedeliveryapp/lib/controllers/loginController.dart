import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';

class LoginResult {
  final bool success;
  final String role;
  final String errorMessage;
  final String accessToken;

  LoginResult({
    required this.success,
    this.role = '',
    this.errorMessage = '',
    this.accessToken = '',
  });
}

Future<LoginResult> loginAndGetAccessToken(
    BuildContext context, String username, String password) async {
    String apiUrl = API.API_URL + '/users/login';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String accessToken = responseData['accessToken'];
      final String role = responseData['role'];
      final String username = responseData['username'];

      Provider.of<AuthModel>(context, listen: false).setToken(accessToken,username);

      return LoginResult(
        success: true,
        role: role,
        accessToken: accessToken,
      );
    } else {
      return LoginResult(
        success: false,
        errorMessage: 'Failed to login. Status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    return LoginResult(
      success: false,
      errorMessage: 'Exception occurred: $e',
    );
  }
}
