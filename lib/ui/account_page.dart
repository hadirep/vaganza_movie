import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/ui/login_page.dart'; // Import Firebase Authentication

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const String routeName = 'account_page';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser; // Dapatkan pengguna saat ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          elevation: 1,
          title: const Center(
            child: Text(
              "Akun Saya",
              style: TextStyle(color: secondaryColor),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await _auth.signOut();

                navigator.pushReplacementNamed(LoginPage.routeName);
              },
              icon: const Icon(
                Icons.logout, color: secondaryColor,
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Nama"),
            subtitle: Text(user?.displayName ?? ''),
          ),
          ListTile(
            title: const Text("Email"),
            subtitle: Text(user?.email ?? ''),
          ),
        ],
      ),
    );
  }
}