import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/category.dart';
import 'package:vrksh_vaatika/model/garden.dart';
import 'package:vrksh_vaatika/model/garden_item.dart';
import 'package:vrksh_vaatika/model/user_update_response.dart';

import 'network_repository.dart';

class GardenService {
  static Future<Garden> getGarden(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(mContext, '/api/garden/list', {}, user.token)
        .then((value) {
      return Garden.fromJson(value);
    });
  }

  static Future<Category> getCategory(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callGetMethod(mContext, '/api/category/list', {}, user.token)
        .then((value) {
      return Category.fromJson(value);
    });
  }

  static Future postPlantItem(BuildContext mContext, GardenItem item) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return callPostMethodWithToken(
            mContext, '/api/garden/create', item.toMap(), user.token)
        .then((value) {
      return value;
    });
  }
}
