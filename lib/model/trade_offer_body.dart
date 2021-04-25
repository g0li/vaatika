// To parse this JSON data, do
//
//     final tradeOffersBody = tradeOffersBodyFromMap(jsonString);

import 'dart:convert';

class TradeOffersBody {
  TradeOffersBody({
    this.offeredListingId,
    this.isAccepted,
    this.isConfirmedByLister,
    this.isConfirmedByOfferer,
  });

  final int offeredListingId;
  final bool isAccepted;
  final bool isConfirmedByLister;
  final bool isConfirmedByOfferer;

  factory TradeOffersBody.fromJson(String str) =>
      TradeOffersBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TradeOffersBody.fromMap(Map<String, dynamic> json) => TradeOffersBody(
        offeredListingId: json["offeredListingId"],
        isAccepted: json["isAccepted"],
        isConfirmedByLister: json["isConfirmedByLister"],
        isConfirmedByOfferer: json["isConfirmedByOfferer"],
      );

  Map<String, dynamic> toMap() => {
        "offeredListingId": offeredListingId,
        "isAccepted": isAccepted,
        "isConfirmedByLister": isConfirmedByLister,
        "isConfirmedByOfferer": isConfirmedByOfferer,
      };
}
