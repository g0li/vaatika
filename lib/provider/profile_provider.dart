import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/user_body.dart';
import 'package:vrksh_vaatika/services/profile_services.dart';

class ProfileProvider extends ChangeNotifier {
  User firebaseUser;
  SharedPreferences preferences;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AppUser appUser;
  CameraPosition userLocation;
  bool edit = false;
  ProfileProvider(BuildContext mContext) {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
      ProfileService.getUserData(mContext).then((aUsr) {
        appUser = aUsr;
        nameController = TextEditingController(text: appUser.name);
        phoneController = TextEditingController(text: appUser.contact);
        userLocation = CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(appUser.lat, appUser.lng),
            zoom: 19.151926040649414);
        notifyListeners();
        // saveUserData(appUser).then((b) => notifyListeners());
      });
    });
  }

  editProfile() {
    edit = !edit;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      firebaseUser = null;
      preferences.clear();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  Future<bool> saveUserData(AppUser user) {
    return SharedPreferences.getInstance().then((pref) {
      return pref.setString('USER', user.toJson());
    });
  }

  updateProfile(mContext, UserBody body) {
    ProfileService.updateProfile(mContext, body).then((value) {
      edit = false;
      print(value.message);
      notifyListeners();
    });
  }
}
