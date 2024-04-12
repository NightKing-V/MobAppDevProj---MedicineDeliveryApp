import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:medicinedeliveryapp/models/prescription_model.dart';
import 'package:provider/provider.dart';

Future<List<Prescription>> getPrescriptions(BuildContext context) async {
  final String apiUrl = API.API_URL + '/prescriptions/getAll';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);
  if (response.statusCode == 200) {
    List jsonData = json.decode(response.body)['data'] as List;
    List<Prescription> prescription = jsonData
        .map<Prescription>((jsonItem) =>
            Prescription.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
    return prescription;
  } else {
    throw Exception('Failed to fetch prescription data');
  }
}
