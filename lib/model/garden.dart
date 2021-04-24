// To parse this JSON data, do
//
//     final garden = gardenFromMap(jsonString);

import 'dart:convert';

class Garden {
  Garden({
    this.status,
    this.message,
    this.data,
  });

  final int status;
  final String message;
  final List<Datum> data;

  factory Garden.fromJson(String str) => Garden.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Garden.fromMap(Map<String, dynamic> json) => Garden(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.plantName,
    this.categoryId,
    this.description,
    this.image,
    this.ownedSince,
    this.quantity,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String userId;
  final String plantName;
  final int categoryId;
  final String description;
  final dynamic image;
  final dynamic ownedSince;
  final int quantity;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["userId"],
        plantName: json["plantName"],
        categoryId: json["categoryId"],
        description: json["description"],
        image: json["image"],
        ownedSince: json["ownedSince"],
        quantity: json["quantity"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "plantName": plantName,
        "categoryId": categoryId,
        "description": description,
        "image": image,
        "ownedSince": ownedSince,
        "quantity": quantity,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
