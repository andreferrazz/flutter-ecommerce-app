import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/custom_user.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:provider/provider.dart';

class UserStorageService {
  static final UserStorageService _instance = UserStorageService._internal();

  factory UserStorageService() {
    return _instance;
  }

  UserStorageService._internal();

  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  // Store a CustomUser in Firestore
  Future<bool> addUser(CustomUser user) {
    return _users
        .doc(user.id)
        .set(user.toJson())
        .then((value) => true)
        .catchError((err) {
      print('Failed to add user: $err');
      return false;
    });
  }

  // Get CustomUser from firebase
  Future<CustomUser> getUserById(String id) {
    return _users
        .doc(id)
        .get()
        .then((value) => CustomUser.fromJson(value.data()));
  }
}
