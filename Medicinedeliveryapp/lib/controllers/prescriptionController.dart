import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:medicinedeliveryapp/models/prescription_model.dart';
import 'package:mime/mime.dart';
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

Future<List<Prescription>> getPrescriptionByPharmacy(
    BuildContext context) async {
  print("in");
  final String apiUrl = API.API_URL + '/prescriptions/getPharmacy';
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
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  final response = await http.delete(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    print("Order deleted successfully");
  } else {
    throw Exception('Failed to delete order');
  }
}

Future<String> uploadPrescription({
  required BuildContext context,
  required File imageFile,
}) async {
  final String apiUrl = API.API_URL + '/prescriptions/place';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer $accessToken',
  };

  final uri = Uri.parse(apiUrl);

  try {
    var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);
    final mimeTypeData =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');

    var picture = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: mimeTypeData != null
          ? MediaType(mimeTypeData[0], mimeTypeData[1])
          : null,
    );

    request.files.add(picture);

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Prescription uploaded successfully.');
      return "done";
    } else {
      print(
          'Failed to upload Prescription. Status code: ${response.statusCode}');
      return "failed";
    }
  } catch (e) {
    print('Error uploading product: $e');
    return "failed";
  }
}

Future<void> acceptPrescription(BuildContext context, String id) async {
  final String apiUrl = API.API_URL + '/prescriptions/status/$id';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("order state changed");
    } else {
      print('Failed to change order state: Status Code ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to fetch data: ${response.body}');
    }
  } catch (e) {
    print('An error occurred: $e');
    throw Exception('An error occurred when trying to change the order state');
  }
}
