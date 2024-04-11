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

Future<void> changeState(BuildContext context, String orderID) async {
  print(orderID);
  final String apiUrl = API.API_URL + '/orders/status/$orderID';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  final body = jsonEncode({
    'status': 'delivering',
  });

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print("order state changed");
      // Optionally process the response data if needed
      // final data = jsonDecode(response.body);
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

Future<void> completeOrder(BuildContext context, String orderID) async {
  print(orderID);
  final String apiUrl = API.API_URL + '/orders/status/$orderID';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  final body = jsonEncode({
    'status': 'completed',
  });

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print("order state changed");
      // Optionally process the response data if needed
      // final data = jsonDecode(response.body);
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

Future<void> deleteOrderById(BuildContext context, String orderId) async {
  final String apiUrl = API.API_URL + '/orders/delete/$orderId';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

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
