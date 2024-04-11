// To parse this JSON data, do
//
//     final productItem = productItemFromJson(jsonString);

import 'dart:convert';

List<ProductItem> productItemFromJson(String str) => List<ProductItem>.from(json.decode(str).map((x) => ProductItem.fromJson(x)));

String productItemToJson(List<ProductItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductItem {
    String activeIngredient;
    String id;
    String name;
    String description;
    double price;
    String category;
    int stockQuantity;
    String dosageForm;
    String manufacturer;
    DateTime expiryDate;
    List<String> images;
    String pharmacyId;
    DateTime createdAt;
    DateTime updatedAt;

    ProductItem({
        required this.activeIngredient,
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.category,
        required this.stockQuantity,
        required this.dosageForm,
        required this.manufacturer,
        required this.expiryDate,
        required this.images,
        required this.pharmacyId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        activeIngredient: json["activeIngredient"],
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        category: json["category"],
        stockQuantity: json["stockQuantity"],
        dosageForm: json["dosageForm"],
        manufacturer: json["manufacturer"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        images: List<String>.from(json["images"].map((x) => x)),
        pharmacyId: json["pharmacyID"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "activeIngredient": activeIngredient,
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "stockQuantity": stockQuantity,
        "dosageForm": dosageForm,
        "manufacturer": manufacturer,
        "expiryDate": expiryDate.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "pharmacyID": pharmacyId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
