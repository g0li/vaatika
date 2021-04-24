// To parse this JSON data, do
//
//     final listingsBody = listingsBodyFromMap(jsonString);

import 'dart:convert';

class ListingsBody {
  ListingsBody({
    this.data,
    this.lookingFor,
  });

  final List<Datum> data;
  final String lookingFor;

  factory ListingsBody.fromJson(String str) =>
      ListingsBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListingsBody.fromMap(Map<String, dynamic> json) => ListingsBody(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        lookingFor: json["lookingFor"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "lookingFor": lookingFor,
      };
}

class Datum {
  Datum({
    this.gardenId,
    this.quantity,
  });

  final int gardenId;
  final int quantity;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        gardenId: json["gardenId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "gardenId": gardenId,
        "quantity": quantity,
      };
}
