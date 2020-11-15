import 'package:anisan/views/screens/home/home.dart';
import 'package:anisan/views/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Sign out
  static signOut() {
    auth.signOut();
  }

  //SignIn
  static Future<UserCredential> signIn(AuthCredential authCreds) {
    return auth.signInWithCredential(authCreds);
  }

  static Future<UserCredential> signInWithOTP(String smsCode, String verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    return Auth.signIn(authCreds);
  }
}
