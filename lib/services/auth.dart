import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create custom user from firebase user

  // Monitor user authentication
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      User firebaseUser = userCredential.user;
      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in with email and password

// Register with email and password

// Sign in with Google or create account and bind to it

// Sign out
}
