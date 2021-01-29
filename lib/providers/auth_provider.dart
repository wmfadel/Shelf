import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shelf/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();
  String uid, name, photo, email;

  loginWithGoogle() async {
    User user = await _authService.signInWithGoogle();
    uid = user.uid;
    _loadUser();
    return uid == null ? false : true;
  }

  Future<bool> autoLogin() async {
    uid = await _authService.checkLoggedUser();
    _loadUser();
    return uid == null ? false : true;
  }

  _loadUser() async {
    email = await _authService.loadUserEmailFromCach();
    name = await _authService.loadUserNameFromCach();
    photo = await _authService.loadUserPhotoFromCach();
  }
}
