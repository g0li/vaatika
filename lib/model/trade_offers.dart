// To parse this JSON data, do
//
//     final tradeOffers = tradeOffersFromMap(jsonString);

import 'dart:convert';

class TradeOffers {
  TradeOffers({
    this.status,
    this.data,
  });

  final int status;
  final List<Datum> data;

  factory TradeOffers.fromJson(String str) =>
      TradeOffers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TradeOffers.fromMap(Map<String, dynamic> json) => TradeOffers(
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
    this.offerId,
    this.listingId,
    this.offeredListingId,
    this.listerName,
    this.offererName,
    this.listerProfilePicture,
    this.offererProfilePicture,
    this.listerId,
    this.offererId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  final int offerId;
  final int listingId;
  final int offeredListingId;
  final String listerName;
  final String offererName;
  final String listerProfilePicture;
  final String offererProfilePicture;
  final String listerId;
  final String offererId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        offerId: json["offerId"],
        listingId: json["listingId"],
        offeredListingId: json["offeredListingId"],
        listerName: json["listerName"],
        offererName: json["offererName"],
        listerProfilePicture: json["listerProfilePicture"] == null
            ? null
            : json["listerProfilePicture"],
        offererProfilePicture: json["offererProfilePicture"] == null
            ? null
            : json["offererProfilePicture"],
        listerId: json["listerId"],
        offererId: json["offererId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "offerId": offerId,
        "listingId": listingId,
        "offeredListingId": offeredListingId,
        "listerName": listerName,
        "offererName": offererName,
        "listerProfilePicture":
            listerProfilePicture == null ? null : listerProfilePicture,
        "offererProfilePicture":
            offererProfilePicture == null ? null : offererProfilePicture,
        "listerId": listerId,
        "offererId": offererId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "status": status,
      };
}
