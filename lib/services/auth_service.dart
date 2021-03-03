import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
    User currentUser = _auth.currentUser;

    print("User Name: ${currentUser.displayName}");
    print("User Email ${currentUser.email}");
    print("User UID ${currentUser.uid}");
    print("User Photo ${currentUser.photoURL}");
    //cachUser(currentUser);
    await cashUserID(currentUser.uid);
    String location = await _getUserLocation();
    FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(
      {
        'name': currentUser.displayName,
        'photo': currentUser.photoURL,
        'email': currentUser.email,
        'location': location,
        'visibility': true,
      },
    );
    return currentUser;
  }

  Future<String> _getUserLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData locData = await location.getLocation();
    return '${locData.latitude},${locData.longitude}';
  }

  cashUserID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('started storing user data in prefs');
    prefs.setString('uid', id);
  }

  Future<String> checkLoggedUser() async {
    if (await _googleSignIn.isSignedIn()) {
      print('user is signed');
      return await loadUserIDFromCach();
    }
    return null;
  }

  Future<String> loadUserIDFromCach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('uid');
    print('id from prefs: $id');
    return id;
  }
}
