import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    cachUser(currentUser);
    return currentUser;
  }

  cachUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('started storing user data in prefs');
    prefs.setString('uid', user.uid);
    prefs.setString('email', user.email);
    prefs.setString('name', user.displayName);
    prefs.setString('photo', user.photoURL);
    print('done storing user data in prefs');
  }

  Future<String> checkLoggedUser() async {
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {}
    return null;*/
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

  Future<String> loadUserNameFromCach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    print('name from prefs: $name');
    return name;
  }

  Future<String> loadUserEmailFromCach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    print('email from prefs: $email');
    return email;
  }

  Future<String> loadUserPhotoFromCach() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String photo = prefs.getString('photo');
    print('photo from prefs: $photo');
    return photo;
  }
}
