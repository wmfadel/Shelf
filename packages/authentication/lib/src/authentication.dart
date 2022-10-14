import 'package:authentication/src/firebase_auth_wrapper.dart';
import 'package:authentication/src/models/firebase_to_app_user_mapper.dart';
import 'package:authentication/src/firebase_user_store.dart';
import 'package:authentication/src/user_secure_storage.dart';
import 'package:domain_models/domain_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:location_service/location_service.dart';
import 'package:rxdart/rxdart.dart';

import 'models/exceptions.dart';

/// This class handles user authentication details and keeps track of the current
/// user state.
class Authentication {
  Authentication({
    @visibleForTesting UserSecureStorage? secureStorage,
    @visibleForTesting FirebaseAuthWrapper? firebaseAuthWrapper,
    @visibleForTesting FirebaseUserStore? firebaseUserStore,
    @visibleForTesting LocationService? locationService,
  })  : _secureStorage = secureStorage ?? const UserSecureStorage(),
        _firebaseAuthWrapper = firebaseAuthWrapper ?? FirebaseAuthWrapper(),
        _firebaseUserStore = firebaseUserStore ?? FirebaseUserStore(),
        _locationService = locationService ?? LocationService();

  final UserSecureStorage _secureStorage;
  final FirebaseAuthWrapper _firebaseAuthWrapper;
  final FirebaseUserStore _firebaseUserStore;
  final LocationService _locationService;
  final BehaviorSubject<AppUser?> _userSubject = BehaviorSubject();

  /// this method provides a stream the keeps the listener updated with the
  /// current user state.
  ///
  /// if the user object emitted in the stream is `null` this means the user
  /// is not authenticated.
  Stream<AppUser?> getUser() async* {
    if (!_userSubject.hasValue) {
      final userInfo = await _secureStorage.getUserInfo();

      if (userInfo != null && userInfo.isValidUserModel) {
        _userSubject.add(userInfo);
      } else {
        _userSubject.add(null);
      }
    }
    yield* _userSubject.stream;
  }

  /// Authenticates a user with email and password via [FirebaseAuthWrapper]
  /// then fetches the user's profile from [FirebaseUserStore] and creates a new
  /// user if a profile does not exist.
  ///
  /// No value is returned from this method to get the result listen to the
  /// user stream using [getUser] which provides a `Stream<AppUser?>`.
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _checkUserAndEmit(
      await _firebaseAuthWrapper.loginWithEmailAndPassword(
          email: email, password: password),
    );
  }

  /// Authenticates a new user with email and password via [FirebaseAuthWrapper]
  /// then fetches the user's profile from [FirebaseUserStore] and creates a new
  /// user if a profile does not exist.
  ///
  /// No value is returned from this method to get the result listen to the
  /// user stream using [getUser] which provides a `Stream<AppUser?>`.
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _checkUserAndEmit(
      await _firebaseAuthWrapper.registerWithEmailAndPassword(
          email: email, password: password),
    );
  }

  /// Authenticates a user with Google auth via [FirebaseAuthWrapper]
  /// then fetches the user's profile from [FirebaseUserStore] and creates a new
  /// user if a profile does not exist.
  ///
  /// No value is returned from this method to get the result listen to the
  /// user stream using [getUser] which provides a `Stream<AppUser?>`.
  Future<void> authenticateWithGoogle() async {
    await _checkUserAndEmit(
      await _firebaseAuthWrapper.authenticateWithGoogle(),
    );
  }

  /// Authenticates a user with Twitter auth via [FirebaseAuthWrapper]
  /// then fetches the user's profile from [FirebaseUserStore] and creates a new
  /// user if a profile does not exist.
  ///
  /// No value is returned from this method to get the result listen to the
  /// user stream using [getUser] which provides a `Stream<AppUser?>`.
  Future<void> authenticateWithTwitter() async {
    await _checkUserAndEmit(
      await _firebaseAuthWrapper.authenticateWithTwitter(),
    );
  }

  /// After authenticating user check if there is a profile for the user in
  /// [FirebaseUserStore] if not create a new profile.
  ///
  /// then emit the profile value to the user stream after saving locally.
  Future<void> _checkUserAndEmit(User? user) async {
    if (user == null) throw AuthenticationFailedException();

    AppUser? appUser = await _firebaseUserStore.fetchRemoteUser(authUser: user);
    if (appUser == null) {
      appUser ??= user.toAppUser(
        location: await _locationService.getUserLocation(),
      );
      await _firebaseUserStore.createRemoteUser(user: appUser);
    }
    _secureStorage.upsertUserInfo(user: appUser);

    _userSubject.add(appUser);
  }
}
