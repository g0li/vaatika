// To parse this JSON data, do
//
//     final loginBody = loginBodyFromMap(jsonString);

import 'dart:convert';

class UserUpdateResponse {
  UserUpdateResponse({
    this.status,
    this.message,
  });

  final int status;
  final String message;

  factory UserUpdateResponse.fromJson(String str) =>
      UserUpdateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserUpdateResponse.fromMap(Map<String, dynamic> json) =>
      UserUpdateResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
      };
}
