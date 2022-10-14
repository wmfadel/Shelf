import 'package:authentication/src/models/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

/// offers different auth methods to the user
/// email and password && google && twitter && anonymous.
/// all return a [User] object.
///
/// also offers a way to sign out.
///
class FirebaseAuthWrapper {
  /// Takes in an optional FirebaseAuth instance, which is useful for testing.
  /// same with a GoogleSignIn instance and a TwitterLogin instance
  FirebaseAuthWrapper({
    @visibleForTesting FirebaseAuth? firebaseAuth,
    @visibleForTesting GoogleSignIn? googleSignIn,
    @visibleForTesting TwitterLogin? twitterLogin,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _twitterLogin = twitterLogin ??
            TwitterLogin(
              apiKey: const String.fromEnvironment('twitterApiKey'),
              apiSecretKey: const String.fromEnvironment('twitterApiSecretKey'),
              redirectURI: const String.fromEnvironment('twitterRedirectUri'),
            );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final TwitterLogin _twitterLogin;

  /// This method initiates Google Sign in process and returns a Firebase [User]
  /// model if the process is successful.
  ///
  /// Throws an [GoogleSignInFailedException] if failed to init Google Sign in.
  ///
  /// Other Firebase Exceptions may be thrown if the process is unsuccessful.
  /// See [FirebaseAuth.signInWithCredential] for more details about exceptions.
  ///
  Future<User?> authenticateWithGoogle() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) throw GoogleSignInFailedException();

    final GoogleSignInAuthentication googleAuth = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  /// This method initiates Twitter Sign in and returns a Firebase [User] model
  /// if the process is successful.
  ///
  /// Throws an [TwitterSignInFailedException] if failed to init Twitter Sign in
  ///
  /// Other Firebase Exceptions may be thrown if the process is unsuccessful.
  /// See [FirebaseAuth.signInWithCredential] for more details about exceptions.
  ///
  Future<User?> authenticateWithTwitter() async {
    final authResult = await _twitterLogin.login();
    if (authResult.authToken == null || authResult.authTokenSecret == null) {
      throw TwitterSignInFailedException();
    }
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    return userCredential.user;
  }

  /// This method wraps the Firebase [signInWithEmailAndPassword] method and
  /// returns a [User] model if the process is successful.
  ///
  /// Firebase Exceptions may be thrown if the process is unsuccessful
  /// See [FirebaseAuth.signInWithEmailAndPassword] for more details about exceptions.
  ///
  Future<User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  /// This method wraps the Firebase [createUserWithEmailAndPassword] method and
  /// returns a [User] model if the process is successful.
  ///
  /// Firebase Exceptions may be thrown if the process is unsuccessful
  /// See [FirebaseAuth.createUserWithEmailAndPassword] for more details about exceptions.
  ///
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  /// This method wraps the Firebase [signInAnonymously] method and
  /// returns a [User] model if the process is successful.
  ///
  /// Firebase Exceptions may be thrown if the process is unsuccessful
  /// See [FirebaseAuth.signInAnonymously] for more details about exceptions.
  ///
  /// NOTE: Take extra care when using this method, as it does not require
  /// any authentication credentials. and anonymous users may often be treated
  /// differently than authenticated users. It is recommended to use this method
  /// if offering a way to user your app without authentication but want to keep
  /// track of analytics or want a token for all user to provide
  /// [FirebaseFirestore] date
  ///
  Future<User?> signInAnonymously() async {
    UserCredential credential = await _firebaseAuth.signInAnonymously();
    return credential.user;
  }

  /// This method wraps the Firebase [signOut] method and signs out of
  /// [GoogleSignIn] if the current user was authenticated with Google.
  ///
  /// Firebase Exceptions may be thrown if the process is unsuccessful
  /// See [FirebaseAuth.signOut] for more details about exceptions.
  ///
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.isSignedIn() ? _googleSignIn.signOut() : null;
  }
}
