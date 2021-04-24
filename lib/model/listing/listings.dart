// To parse this JSON data, do
//
//     final listings = listingsFromMap(jsonString);

import 'dart:convert';

class Listings {
  Listings({
    this.status,
    this.data,
  });

  final int status;
  final List<Datum> data;

  factory Listings.fromJson(String str) => Listings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listings.fromMap(Map<String, dynamic> json) => Listings(
        status: json["status"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.id,
    this.lookingFor,
    this.quantity,
    this.plantName,
    this.gardenId,
    this.image,
    this.categoryId,
    this.category,
    this.description,
    this.ownedSince,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String lookingFor;
  final int quantity;
  final String plantName;
  final int gardenId;
  final String image;
  final int categoryId;
  final String category;
  final String description;
  final dynamic ownedSince;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lookingFor: json["lookingFor"],
        quantity: json["quantity"],
        plantName: json["plantName"],
        gardenId: json["gardenId"],
        image: json["image"] == null ? null : json["image"],
        categoryId: json["categoryId"],
        category: json["category"],
        description: json["description"] == null ? null : json["description"],
        ownedSince: json["ownedSince"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "lookingFor": lookingFor,
        "quantity": quantity,
        "plantName": plantName,
        "gardenId": gardenId,
        "image": image == null ? null : image,
        "categoryId": categoryId,
        "category": category,
        "description": description == null ? null : description,
        "ownedSince": ownedSince,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
