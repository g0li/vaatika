import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future submitOTP(smsCode) {
    this.phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.vId, smsCode: smsCode);
    return login();
  }

  User firebaseUser;
  Future<void> login() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this.phoneAuthCredential)
          .then((UserCredential authRes) {
        firebaseUser = authRes.user;
        print(firebaseUser.toString());
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
      notifyListeners();
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
}
