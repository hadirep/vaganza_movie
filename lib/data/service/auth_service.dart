import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../ui/admin/admin_page.dart';
import '../../ui/home_page.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final String _adminUID = "j9o2bBJz2paxcoMZ4ykSqMvrmEa2";

  Future<void> register(email, password, context)async{
    final navigator = Navigator.of(context);

    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    navigator.pop();
  }

  Future<void> login(email, password, context) async {
    final navigator = Navigator.of(context);

    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if(user != null) {
      if(user.uid == _adminUID) {
        navigator.pushReplacementNamed(AdminPage.routeName);
      } else {
        navigator.pushReplacementNamed(HomePage.routeName);
      }
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}