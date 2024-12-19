import 'package:famscreen/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/CameraPage.dart';

class AuthService {
  // Email validation regex
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  // Validate Email Format
  bool isValidEmail(String email) {
    if (!emailRegex.hasMatch(email)) {
      showInvalidEmailToast();
      return false;
    }
    return true;
  }

  // GOOGLE SIGNIN
  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        Fluttertoast.showToast(
          msg: 'Google sign-in canceled',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Sign-in failed: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: 'An unexpected error occurred: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // Anonymous Sign In
  Future<void> anonymousSignin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPage(),
        ),
      );
    } catch (e) {
      print('Error signing in anonymously: $e');
    }
  }

  // Sign Up
  Future<void> signup({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    if (!isValidEmail(email)) return;

    try {
      // Call the Firebase signup function
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the displayName
      await userCredential.user?.updateDisplayName(name);

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
          builder: (context) => CameraPage(),
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
    if (!isValidEmail(email)) return;

    try {
      // Call the Firebase sigin function
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
          builder: (context) => CameraPage(),
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
      print('Error signing in: $e');
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

  // Lupa Password
  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    if (!isValidEmail(email)) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Fluttertoast.showToast(
        msg: 'Email reset password telah dikirim',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Handle errors
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'Email tidak terdaftar';
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
      print('Error resetting password: $e');
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

// Show Invalid Email Toast
void showInvalidEmailToast() {
  Fluttertoast.showToast(
    msg: 'Format email tidak sesuai',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
