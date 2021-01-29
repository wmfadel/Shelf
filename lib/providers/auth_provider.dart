import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shelf/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();
  String uid;

  loginWithGoogle() async {
    User user = await _authService.signInWithGoogle();
    uid = user.uid;
  }

  Future<bool> autoLogin() async {
    uid = await _authService.checkLoggedUser();
    return uid == null ? false : true;
  }
}
