import 'dart:convert';

List<Prescription> prescriptionFromJson(String str) => List<Prescription>.from(json.decode(str).map((x) => Prescription.fromJson(x)));

String prescriptionToJson(List<Prescription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prescription {
    String id;
    UserId userId;
    String prescriptionImage;
    String pickedup;
    DateTime createdAt;
    DateTime updatedAt;

    Prescription({
        required this.id,
        required this.userId,
        required this.prescriptionImage,
        required this.pickedup,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["_id"],
        userId: UserId.fromJson(json["userID"]),
        prescriptionImage: json["prescriptionImage"],
        pickedup: json["pickedup"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId.toJson(),
        "prescriptionImage": prescriptionImage,
        "pickedup": pickedup,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class UserId {
    Address address;
    String id;
    String firstName;
    String lastName;
    DateTime dob;
    String nic;
    String contactNo;
    String email;
    String username;
    String password;
    String role;
    DateTime createdAt;
    DateTime updatedAt;

    UserId({
        required this.address,
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.dob,
        required this.nic,
        required this.contactNo,
        required this.email,
        required this.username,
        required this.password,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        address: Address.fromJson(json["address"]),
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: DateTime.parse(json["dob"]),
        nic: json["nic"],
        contactNo: json["contactNo"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob.toIso8601String(),
        "nic": nic,
        "contactNo": contactNo,
        "email": email,
        "username": username,
        "password": password,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Address {
    String street;
    String city;
    String state;
    String zipCode;

    Address({
        required this.street,
        required this.city,
        required this.state,
        required this.zipCode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "zipCode": zipCode,
    };
}
