import 'package:flutter/foundation.dart';
import 'package:shelf/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  loginWithGoogle() async {
    _authService.signInWithGoogle();
  }
}
