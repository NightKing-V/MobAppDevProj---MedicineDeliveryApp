import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicinedeliveryapp/models/authModel.dart';
import 'package:medicinedeliveryapp/models/config.dart';
import 'package:medicinedeliveryapp/models/product_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

Future<List<dynamic>> fetchAllProductsByPharmacy(BuildContext context) async {
  final String apiUrl = API.API_URL + '/products/allProductsPharmacy';
  final authModel = Provider.of<AuthModel>(context, listen: false);
  final String accessToken = authModel.accessToken;
  

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<List<ProductItem>> getProducts(BuildContext context) async {
  final String apiUrl = API.API_URL + '/products/allProductsPharmacy';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {

    List jsonData = json.decode(response.body)['data'] as List;
    List<ProductItem> items = jsonData
        .map<ProductItem>(
            (jsonItem) => ProductItem.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
    return items;
  } else {
    throw Exception('Failed to fetch cart data');
    
  }
}

Future<void> deleteFromProduct(BuildContext context, String productID) async {
  final String apiUrl = API.API_URL + '/products/remove/$productID';
  final String accessToken = Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.delete(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
    print("Order deleted successfully");
  } else {
    throw Exception('Failed to delete order');
  }
}

Future<void> uploadProduct({
  required BuildContext context, 
  required String name,
  required String description,
  required String price,
  required String category,
  required String stockQuantity,
  required String dosageForm,
  required String activeIngredients,
  required String manufacturer,
  required String expiryDate,
  required File imageFile,
}) async {

  final String apiUrl = API.API_URL + '/products/add';
  final String accessToken =
      Provider.of<AuthModel>(context, listen: false).accessToken;

  final headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer $accessToken',
  };

  final uri = Uri.parse(apiUrl);

  try {
    var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['category'] = category;
    request.fields['stockQuantity'] = stockQuantity;
    request.fields['dosageForm'] = dosageForm;
    request.fields['activeIngredients'] = activeIngredients;
    request.fields['manufacturer'] = manufacturer;
    request.fields['expiryDate'] = expiryDate;

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
      print('Product uploaded successfully.');
    } else {
      print('Failed to upload product. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading product: $e');
  }
}
