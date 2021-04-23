// To parse this JSON data, do
//
//     final loginBody = loginBodyFromMap(jsonString);

import 'dart:convert';

class UserBody {
  UserBody({
    this.id,
    this.name,
    this.contact,
    this.lat,
    this.lng,
    this.deviceId,
    this.os,
  });

  final String id;
  final String name;
  final String contact;
  final double lat;
  final double lng;
  final String deviceId;
  final String os;

  factory UserBody.fromJson(String str) => UserBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserBody.fromMap(Map<String, dynamic> json) => UserBody(
        id: json["id"],
        name: json["name"],
        contact: json["contact"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        deviceId: json["deviceId"],
        os: json["os"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "contact": contact,
        "lat": lat,
        "lng": lng,
        "deviceId": deviceId,
        "os": os,
      };
}
