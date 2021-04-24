// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    this.status,
    this.categoryList,
    this.message,
  });

  final int status;
  final List<CategoryList> categoryList;
  final String message;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        status: json["status"],
        categoryList: List<CategoryList>.from(
            json["categoryList"].map((x) => CategoryList.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toMap())),
        "message": message,
      };
}

class CategoryList {
  CategoryList({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CategoryList.fromJson(String str) =>
      CategoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryList.fromMap(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
