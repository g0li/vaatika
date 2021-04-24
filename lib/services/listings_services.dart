import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/listing/listing_body.dart';
import 'package:vrksh_vaatika/model/listing/listings.dart';
import 'package:vrksh_vaatika/model/user_update_response.dart';

import 'network_repository.dart';

class ListingsService {
  static Future<Listings> getListings(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(mContext, '/api/listing/list', {}, user.token)
        .then((value) {
      return Listings.fromJson(value);
    });
  }

  static Future createListing(BuildContext mContext, ListingsBody item) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callPostMethodWithToken(
            mContext, '/api/listing/create', item.toMap(), user.token)
        .then((value) {
      return UserUpdateResponse.fromJson(value);
    });
  }

  // static Future updatePlantItem(BuildContext mContext, GardenItem item) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   AppUser user = AppUser.fromJson(pref.getString('USER'));
  //   return callPostMethodWithToken(
  //           mContext, '/api/garden/update', item.toMap(), user.token)
  //       .then((value) {
  //     return value;
  //   });
  // }

  // static Future deletePlant(BuildContext mContext, Datum item) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   AppUser user = AppUser.fromJson(pref.getString('USER'));
  //   return callPostMethodWithToken(
  //           mContext, '/api/garden/delete/${item.id}', {}, user.token)
  //       .then((value) {
  //     return UserUpdateResponse.fromJson(value);
  //   });
  // }
}
