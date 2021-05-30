import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelf/services/location_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  logout() {
    _auth.signOut();
    _googleSignIn.signOut();
    clearCash();
  }

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
    User currentUser = _auth.currentUser!;

    print("User Name: ${currentUser.displayName}");
    print("User Email ${currentUser.email}");
    print("User UID ${currentUser.uid}");
    print("User Photo ${currentUser.photoURL}");
    //cachUser(currentUser);
    await cashUserID(currentUser.uid);
    String? location = await LocationService().getUserLocation();
    // check for user existance
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!user.exists) {
      FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(
        {
          'name': currentUser.displayName,
          'photo': currentUser.photoURL,
          'email': currentUser.email,
          'location': location,
          'visibility': location == null ? false : true,
          'upVote': 0,
          'downVote': 0,
        },
      );
      // create shelfs
      addShelf('Want To Read', 'Books i want to read someday', currentUser.uid);
      addShelf('Read', 'Books i finished reading', currentUser.uid);
    }

    return currentUser;
  }

  addShelf(String name, description, userID) {
    FirebaseFirestore.instance.collection('shelfs').add({
      'description': description,
      'isPublic': true,
      'name': name,
      'time': Timestamp.now(),
      'user': userID,
    });
  }

  cashUserID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('started storing user data in prefs');
    prefs.setString('uid', id);
  }

  Future<String?> checkLoggedUser() async {
    if (await _googleSignIn.isSignedIn()) {
      print('user is signed');
      return await loadUserIDFromCach();
    }
    return null;
  }

  Future<String?> loadUserIDFromCach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('uid');
    print('id from prefs: $id');
    return id;
  }

  clearCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
  }
}
