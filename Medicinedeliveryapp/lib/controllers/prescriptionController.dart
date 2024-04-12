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

Future<List<Prescription>> getPrescriptionsByUser(BuildContext context) async {
  final String apiUrl = API.API_URL + '/prescriptions/get';
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

Future<void> deleteFromPrescription(BuildContext context, String id) async {
  final String apiUrl = API.API_URL + '/prescriptions/delete/$id';
  final String accessToken = Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  final response = await http.delete(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    // Successfully deleted the order
    print("Order deleted successfully");
  } else {
    // Handle error scenario
    throw Exception('Failed to delete order');
  }
}