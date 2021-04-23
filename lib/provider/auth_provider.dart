import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrksh_vaatika/model/app_user.dart';
import 'package:vrksh_vaatika/model/user_body.dart';
import 'package:vrksh_vaatika/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  AuthCredential phoneAuthCredential;
  String vId;
  AuthProvider() {}
  Future<void> submitPhoneNumber(phoneNumber) async {
    phoneNumber = "+91 " + phoneNumber.trim();
    print(phoneNumber);

    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      this.phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
      notifyListeners();
    }

    void verificationFailed(error) {
      print(error);
      notifyListeners();
    }

    void codeSent(String verificationId, [int code]) {
      this.vId = verificationId;
      print('codeSent');
      notifyListeners();
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      this.vId = verificationId;
      print('codeAutoRetrievalTimeout');
      notifyListeners();
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 10000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<AppUser> submitOTP(mContext, smsCode) {
    this.phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.vId, smsCode: smsCode);
    return login(mContext);
  }

  User firebaseUser;
  Future<AppUser> login(mContext) async {
    try {
      return FirebaseAuth.instance
          .signInWithCredential(this.phoneAuthCredential)
          .then((UserCredential authRes) async {
        firebaseUser = authRes.user;
        print(firebaseUser.toString());
        var dId = await FirebaseMessaging.instance.getToken();
        UserBody body = UserBody(
            contact: firebaseUser.phoneNumber,
            os: Platform.operatingSystem,
            deviceId: dId,
            name: "Roshan Singh",
            lat: 19,
            lng: 20,
            id: firebaseUser.uid);
        return AuthService.login(mContext, body).then((aUser) async {
          await saveUserData(aUser);
          return aUser;
        });
      });
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return AppUser();
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      firebaseUser = null;
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
}
