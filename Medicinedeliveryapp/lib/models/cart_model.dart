import 'dart:convert';

List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
    String id;
    String user;
    List<Item> items;

    Cart({
        required this.id,
        required this.user,
        required this.items,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        user: json["user"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Product product;
    int quantity;
    String id;

    Item({
        required this.product,
        required this.quantity,
        required this.id,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "_id": id,
    };
}

class Product {
    String id;
    String name;
    double price;
    List<String> images;
    String pharmacyId;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.images,
        required this.pharmacyId,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        images: List<String>.from(json["images"].map((x) => x)),
        pharmacyId: json["pharmacyID"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "pharmacyID": pharmacyId,
    };
}
