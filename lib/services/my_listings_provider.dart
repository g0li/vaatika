import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class MyListingsProvider extends ChangeNotifier {
  Listings listings;
  MyListingsProvider(mContext) {
    ListingsService.getMyListings(mContext).then((listingxs) {
      this.listings = listingxs;
      notifyListeners();
    });
  }
  deleteListing(mContext, id) {
    ListingsService.deleteListings(mContext, id).then((value) {
      ListingsService.getMyListings(mContext).then((listingxs) {
        this.listings = listingxs;
        notifyListeners();
      });
    });
  }
}
