import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/user_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final UserStorageService _userStorageService = UserStorageService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create custom user from firebase user
  CustomUser _getCustomUserFromFirebaseUser(User user) {
    return CustomUser(
      user.uid,
      user.displayName,
      user.email,
      null,
      null,
      null,
    );
  }

  // Monitor user authentication
  Stream<CustomUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _getCustomUserFromFirebaseUser(user));
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

  // Register with email and password
  Future registerUserWithEmailAndPassword(String email, String password,
      {String name = ''}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      CustomUser user = _getCustomUserFromFirebaseUser(userCredential.user);
      user.name = name;

      if (await _userStorageService.addUser(user)) {
        return user;
      } else {
        throw Exception('Failed to store user on firestore.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // CustomUser user = createCustomUserFromFirebaseUser(userCredential.user);
      CustomUser user =
          await _userStorageService.getUserById(userCredential.user.uid);
      if (user != null) {
        return user;
      } else {
        throw Exception('Failed to sign in.');
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.code;
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }

  // TODO: Sign in with Google

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
