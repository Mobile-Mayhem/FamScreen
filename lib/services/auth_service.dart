import 'package:famscreen/pages/LoginPage.dart';
import 'package:famscreen/pages/MovieListPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pages/CameraPage.dart';

class AuthService {
  // Sign Up
  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Call the Firebase signup function
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: 'Registrasi berhasil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CameraPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah digunakan';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  // Sign In
  Future<void> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Call the Firebase signup function
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: 'Login berhasil',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Movielistpage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String message = '';
      if (e.code == 'wrong-password') {
        message = 'Password salah';
      } else if (e.code == 'user-not-found') {
        message = 'Email salah';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  // Sign Out
  Future<void> signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Get UID
  Future<String?> getUID() async {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  // Get Name
  Future<String?> getName() async {
    return FirebaseAuth.instance.currentUser?.displayName;
  }

  // Get Email
  Future<String?> getEmail() async {
    return FirebaseAuth.instance.currentUser?.email;
  }
}
