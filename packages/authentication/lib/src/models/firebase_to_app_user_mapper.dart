import 'package:domain_models/domain_models.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserToAppUser on User {
  AppUser toAppUser({AppLocation? location}) {
    return AppUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      downVote: 0,
      upVote: 0,
      visibility: true,
      location: location,
    );
  }
}