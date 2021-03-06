import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/listing/listing_body.dart' as lb;
import 'package:vrksh_vaatika/model/listing/listings.dart' as l;
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/model/user_update_response.dart';

import 'network_repository.dart';

class ListingsService {
  static Future<Listings> getListings(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(mContext, '/api/listing/nearby', {}, user.token)
        .then((value) {
      return Listings.fromJson(value);
    });
  }

  static Future<Listings> getMyListings(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(mContext, '/api/listing/list', {}, user.token)
        .then((value) {
      return Listings.fromJson(value);
    });
  }

  // get single listing
  static Future<Listings> getSingleListing(
      BuildContext mContext, int listingId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(
            mContext, '/api/listing/get/$listingId', {}, user.token)
        .then((value) {
      Listings listingxs = Listings.fromJson(value);
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
      Listings listing = Listings(
        data: list,
        status: 1,
      );
      return listing;
    }).catchError((err) {
      return null;
    });
  }

  static Future createListing(
      BuildContext mContext, lb.ListingsBody item) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callPostMethodWithToken(
            mContext, '/api/listing/create', item.toMap(), user.token)
        .then((value) {
      return UserUpdateResponse.fromJson(value);
    });
  }

  static Future updateListingItem(
      BuildContext mContext, lb.ListingsBody editable, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    print(editable.toJson());
    return callPostMethodWithToken(
            mContext, '/api/listing/update/$id', editable.toMap(), user.token)
        .then((value) {
      return value;
    });
  }

  static Future deleteListings(BuildContext mContext, id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callDeleteMethodWithToken(
            mContext, '/api/listing/${id}', {}, user.token)
        .then((value) {
      return UserUpdateResponse.fromJson(value);
    });
  }
}
