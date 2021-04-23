import 'package:flutter/widgets.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/user_body.dart';

import 'network_repository.dart' as api;

class AuthService {
  static Future<AppUser> login(BuildContext mContext, UserBody body) {
    Map<String, dynamic> params = {};
    params.addAll(body.toMap());
    print(params);
    return api.callPostMethod(mContext, '/api/login', params).then((value) {
      return AppUser.fromJson(value);
    });
  }
}
