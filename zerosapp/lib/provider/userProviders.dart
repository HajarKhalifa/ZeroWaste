import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:zeros/db/authentication/firebase_auth_methods.dart';

import '../models/users.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:zeros/db/authentication/firebase_auth_methods.dart';

import '../models/users.dart';

class UserProviders extends ChangeNotifier {
  UserCreaditials? _users;
  bool isLoading = false;
  final FirebaseAuthMethods _auth = FirebaseAuthMethods();

  // Getter for _users
  UserCreaditials? get getUser => _users;

  Future<void> refreshUser() async {
    isLoading = true;
    notifyListeners();

    try {
      UserCreaditials userCreaditials = await _auth.getUserDetails();
      _users = userCreaditials;
      print(userCreaditials.address);
    } catch (error) {
      print("Error while refreshing user: $error");
      _users = null; // Set _users to null in case of an error
    }

    isLoading = false;
    notifyListeners();
  }
}
