import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:provider/provider.dart';

Future<List<dynamic>> getAllProducts(BuildContext context) async {
  final String apiUrl = API.API_URL + '/products/allProducts';
  final String accessToken = Provider.of<AuthModel>(context).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    // print(data);
    return data;
  } else {
    throw Exception('Failed to fetch data');
  }
}
