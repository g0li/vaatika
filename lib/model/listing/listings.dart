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
  List<Datum> data;

  factory Listings.fromJson(String str) => Listings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listings.fromMap(Map<String, dynamic> json) => Listings(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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
    this.status,
    this.plantName,
    this.gardenId,
    this.image,
    this.categoryId,
    this.category,
    this.description,
    this.ownedSince,
    this.lat,
    this.lng,
    this.userName,
    this.createdAt,
    this.updatedAt,
    this.plantsList,
  });

  final int id;
  final String lookingFor;
  final int quantity;
  final String status;
  final String plantName;
  final int gardenId;
  final String image;
  final int categoryId;
  final String category;
  final String description;
  final dynamic ownedSince;
  final double lat;
  final double lng;
  final String userName;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<ListingPlants> plantsList;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        lookingFor: json["lookingFor"],
        quantity: json["quantity"],
        status: json["status"],
        plantName: json["plantName"],
        gardenId: json["gardenId"],
        image: json["image"],
        categoryId: json["categoryId"],
        category: json["category"],
        description: json["description"],
        ownedSince: json["ownedSince"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        userName: json["userName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "lookingFor": lookingFor,
        "quantity": quantity,
        "status": status,
        "plantName": plantName,
        "gardenId": gardenId,
        "image": image,
        "categoryId": categoryId,
        "category": category,
        "description": description,
        "ownedSince": ownedSince,
        "lat": lat,
        "lng": lng,
        "userName": userName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class ListingPlants {
  String plantName;
  String description;
  String ownedSince;
  String category;
  int quantity;
  String image;

  ListingPlants({
    this.plantName,
    this.description,
    this.ownedSince,
    this.category,
    this.quantity,
    this.image,
  });
}
