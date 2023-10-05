import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/ui/admin/admin_page.dart';
import 'package:vaganza_movie/ui/home_page.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final String _adminUID = "j9o2bBJz2paxcoMZ4ykSqMvrmEa2";

  // Metode untuk login dengan email dan password
  Future<void> login(email, password, context) async {
    final navigator = Navigator.of(context);

    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      if (user.uid == _adminUID) {
        navigator.pushReplacementNamed(AdminPage.routeName);
      } else {
        navigator.pushReplacementNamed(HomePage.routeName);
      }
    }
  }

  // Metode untuk login dengan kredensial Google
  Future<void> signInWithCredential(AuthCredential credential, context) async {
    final navigator = Navigator.of(context);

    try {
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        final displayName = user.displayName; // Mendapatkan nama pengguna
        final email = user.email; // Mendapatkan email pengguna

        if (user.uid == _adminUID) {
          navigator.pushReplacementNamed(AdminPage.routeName);
        } else {
          navigator.pushReplacementNamed(HomePage.routeName);

          print('Nama Pengguna: $displayName');
          print('Email Pengguna: $email');
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle error
    }
  }

  bool isUserLoggedIn() {
    final user = _auth.currentUser;
    return user != null;
  }

  // Metode untuk register dengan email dan password
  Future<void> register(email, password, context) async {
    final navigator = Navigator.of(context);

    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    navigator.pop();
  }

  // Metode untuk logout
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
