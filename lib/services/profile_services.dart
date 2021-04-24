import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/user_body.dart';
import 'package:vrksh_vaatika/model/user_update_response.dart';

import 'network_repository.dart' as api;

class ProfileService {
  static Future<UserUpdateResponse> updateProfile(
      BuildContext mContext, UserBody body) async {
    Map<String, dynamic> params = {};
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    params.addAll(body.toMap());
    return api
        .callPostMethodWithToken(mContext, '/api/update', params, user.token)
        .then((value) {
      return UserUpdateResponse.fromJson(value);
    });
  }

  static Future<AppUser> getUserData(BuildContext mContext) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AppUser user = AppUser.fromJson(pref.getString('USER'));
    return api
        .callGetMethod(mContext, '/api/user/${user.id}', {}, user.token)
        .then((value) {
      print(value);
      return AppUser.fromJson(value);
    });
  }
}
