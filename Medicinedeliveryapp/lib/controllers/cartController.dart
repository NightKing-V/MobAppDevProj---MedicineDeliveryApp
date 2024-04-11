import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/cart_model.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:medicinedeliveryapp/pages/authentication/login_page.dart';
import 'package:provider/provider.dart';

Future<void> addToCart(
    BuildContext context, String productID, String quantity) async {
  final String apiUrl = API.API_URL + '/cart/add';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'productID': productID, // Assuming the backend expects an 'orderId' field
    'quantity': quantity,
  });

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    print("$productID added to cart");
  } else {
    // Handle error scenario
    throw Exception('Failed add');
  }
}

Future<List<dynamic>> fetchCart(BuildContext context) async {
  final String apiUrl = API.API_URL + '/cart/get';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    print(data);
    return data;
  } else {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
    throw Exception('Failed to fetch cart data');
  }
}

Future<List<Cart>> getCart(BuildContext context) async {
  final String apiUrl = API.API_URL + '/cart/get';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    // Decode the JSON response into a List<dynamic>
    List jsonData = json.decode(response.body)['data'] as List;
    List<Cart> carts = jsonData
        .map<Cart>(
            (jsonItem) => Cart.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
    return carts;
  } else {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
    throw Exception('Failed to fetch cart data');
  }
}

Future<void> deleteFromCart(BuildContext context, String productID) async {
  final String apiUrl = API.API_URL + '/cart/remove/$productID';
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