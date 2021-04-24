// To parse this JSON data, do
//
//     final gardenItem = gardenItemFromMap(jsonString);

import 'dart:convert';

class GardenItem {
  GardenItem({
    this.plantName,
    this.categoryId,
    this.description,
    this.image,
    this.ownedSince,
    this.quantity,
  });

  final String plantName;
  final String categoryId;
  final String description;
  final String image;
  final String ownedSince;
  final String quantity;

  factory GardenItem.fromJson(String str) =>
      GardenItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GardenItem.fromMap(Map<String, dynamic> json) => GardenItem(
        plantName: json["plantName"],
        categoryId: json["categoryId"],
        description: json["description"],
        image: json["image"],
        ownedSince: json["ownedSince"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "plantName": plantName,
        "categoryId": categoryId,
        "description": description,
        "image": image,
        "ownedSince": ownedSince,
        "quantity": quantity,
      };
}
