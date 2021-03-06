// To parse this JSON data, do
//
//     final appUser = appUserFromMap(jsonString);

import 'dart:convert';

class AppUser {
  AppUser({
    this.status,
    this.token,
    this.id,
    this.name,
    this.contact,
    this.lat,
    this.lng,
    this.deviceId,
    this.os,
    this.updatedAt,
    this.createdAt,
    this.message,
    this.profilePicture,
  });

  final int status;
  final String token;
  final String id;
  final String name;
  final String contact;
  double lat;
  double lng;
  final String deviceId;
  final String os;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String message;
  final String profilePicture;

  factory AppUser.fromJson(String str) => AppUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
        status: json["status"],
        token: json["token"],
        id: json["id"],
        name: json["name"],
        contact: json["contact"],
        lat: json["lat"] == null ? 19 : json["lat"].toDouble() ?? 0,
        lng: json["lng"] == null ? 20 : json["lng"].toDouble() ?? 0,
        deviceId: json["deviceId"],
        os: json["os"],
        updatedAt: DateTime.parse(
            json["updatedAt"] ?? DateTime.now().toIso8601String()),
        createdAt: DateTime.parse(
            json["createdAt"] ?? DateTime.now().toIso8601String()),
        message: json["message"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "token": token,
        "id": id,
        "name": name,
        "contact": contact,
        "lat": lat,
        "lng": lng,
        "deviceId": deviceId,
        "os": os,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "message": message,
        "profilePicture": profilePicture,
      };
}
