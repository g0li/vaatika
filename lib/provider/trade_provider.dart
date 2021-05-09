import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/trade_offers.dart';
import 'package:vrksh_vaatika/services/trade_services.dart';

class TradeProvider with ChangeNotifier {
  TradeOffers tradeOfferlist;
  bool tradeLoader;

  TradeProvider(BuildContext mContext,id) {
    setTradeLoader(true);
    TradeServices.getOfferByListing(mContext,id).then((val) {
      tradeOfferlist = val;
      tradeLoader = false;
      notifyListeners();
    }).catchError((err) {
      tradeOfferlist = null;
      setTradeLoader(false);
      notifyListeners();
    });
  }

  setTradeLoader(bool val) {
    tradeLoader = val;
    notifyListeners();
  }
}
