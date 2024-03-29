import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();
  String? uid, name, photo, email, location;

  loginWithGoogle() async {
    User user = await _authService.signInWithGoogle();
    uid = user.uid;
    await _getUserData(uid);
    return uid == null ? false : true;
  }

  logout() {
    _authService.logout();
  }

  Future<bool> autoLogin() async {
    uid = await _authService.checkLoggedUser();
    if (uid != null) {
      await _getUserData(uid);
      return true;
    }
    return false;
  }

  _getUserData(String? uid) async {
    DocumentSnapshot value =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    name = value.get('name');
    email = value.get('email');
    photo = value.get('photo');
    location = value.get('location');
    print(
        'got data from firestore\nname:$name\temail:$email\tlocation:$location\nphoto:$photo');
  }

  Future<bool> checkOnborading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('board')) return true;
    return false;
  }

  completedOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('board', true);
  }
}
