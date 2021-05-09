import 'package:flutter/material.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/services/listings_services.dart';

class MyListingsProvider extends ChangeNotifier {
  Listings listings;
  bool listingLoader = false;

  setListingLoader(bool val) {
    print('Set to $val');
    listingLoader = val;
    notifyListeners();
  }

  MyListingsProvider(mContext) {
    setListingLoader(true);
    ListingsService.getMyListings(mContext).then((listingxs) {
      List<Datum> list = [];
      if (listingxs != null && listingxs.data != null) {
        listingxs.data.forEach((ls) {
          print(ls.plantName);

          ListingPlants pl = ListingPlants(
            category: ls.category,
            description: ls.description,
            ownedSince: ls.ownedSince,
            plantName: ls.plantName,
            quantity: ls.quantity,
            image: ls.image,
          );

          // check if entry exists
          if (list.any((el) => el.id == ls.id)) {
            // exists, add plants
            // get index
            print('${ls.id} exists, adding ${pl.plantName}');
            int indx = list.indexWhere((el) => el.id == ls.id);
            // add
            list[indx].plantsList.add(pl);
          } else {
            // new entry
            print('Added new ${pl.plantName} to ${ls.id}');
            ls.plantsList = [pl];
            list.add(ls);
          }
        });
      }
      setListingLoader(false);
      Listings listing = Listings(
        data: list,
        status: 1,
      );
      this.listings = listing;
      notifyListeners();
    }).catchError((err) {
      print('Error in provider: ${err.toString()}');
      setListingLoader(false);
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
