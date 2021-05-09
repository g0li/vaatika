import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/trade_offers.dart';
import 'package:vrksh_vaatika/services/trade_services.dart';

class OpenListingsProvider extends ChangeNotifier {
  TradeOffers tradeOffers;
  OpenListingsProvider(mContext) {
    TradeServices.getUserTradeOffers(mContext).then((value) {
      tradeOffers = value;
      notifyListeners();
    });
  }
}
