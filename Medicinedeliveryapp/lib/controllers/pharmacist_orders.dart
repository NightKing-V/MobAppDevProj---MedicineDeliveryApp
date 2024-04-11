import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:provider/provider.dart';

Future<List<dynamic>> fetchAllOrdersByPharmacy(BuildContext context) async {
  final String apiUrl = API.API_URL + '/orders/allOrdersPharmacy';
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

Future<void> deleteOrderById(BuildContext context, String orderId) async {
  final String apiUrl = API.API_URL + '/orders/delete/$orderId';
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