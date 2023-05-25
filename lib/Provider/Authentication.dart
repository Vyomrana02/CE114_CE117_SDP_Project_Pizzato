import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid = '';
dynamic errorMessage = '';

class Authentication with ChangeNotifier {
  dynamic get getErrorMessage => errorMessage;
  String get getUid => uid;
  late String userEmail = '';
  String get getEmail => userEmail;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginIntoAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      userEmail = user.email!;
      sharedPreferences.setString('uid', uid);
      sharedPreferences.setString('useremail', userEmail);
      // ignore: avoid_print
      print('uid => $getUid');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorMessage = 'User Not Found';
          // ignore: avoid_print
          print(errorMessage);
          break;
        case 'The password is invalid or the user does not have a password.':
          errorMessage = 'Wrong Password';
          // ignore: avoid_print
          print(errorMessage);
          break;
        case 'The email address is badly formatted.':
          errorMessage = 'The email address is badly formatted.';
          // ignore: avoid_print
          print(errorMessage);
          break;
      }
    }
  }

  Future createNewAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      sharedPreferences.setString('uid', uid);
      // ignore: avoid_print
      print('uid => $getUid');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      /*// ignore: avoid_print
      print(e.message);*/
      switch (e.message) {
        case 'The email address is already in use by another account.':
          errorMessage = 'Email already in use';
          // ignore: avoid_print
          print(errorMessage);
          break;
        case 'The email address is badly formatted.':
          errorMessage = 'Invalid Email';
          // ignore: avoid_print
          print(errorMessage);
          break;
        case 'Password should be at least 6 characters':
          errorMessage = 'Password should be at least 6 characters';
          // ignore: avoid_print
          print(errorMessage);
          break;
      }
    }
  }
}