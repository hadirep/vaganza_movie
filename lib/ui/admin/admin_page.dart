import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/ui/admin/admin_play_page.dart';
import 'package:vaganza_movie/ui/admin/admin_upcoming_page.dart';
import 'package:vaganza_movie/ui/home_page.dart';
import 'package:vaganza_movie/ui/login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  static const String routeName = 'admin_page';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Admin Page',
              style: TextStyle(color: secondaryColor),
            ),
          ),
          backgroundColor: primaryColor,
          leading: Padding(
            padding: const EdgeInsets.symmetric(),
            child: Builder(
              builder: (context) => IconButton(
                icon: Image.asset(
                  'assets/icon.png',
                  height: 50,
                  width: 50,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 50,
                  ),
                ),
                const Divider(color: secondaryColor),
                ListTile(
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: secondaryColor, fontSize: 15),
                  ),
                  trailing: const Icon(Icons.logout, color: secondaryColor),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await _auth.signOut();
                    navigator.pushReplacementNamed(LoginPage.routeName);
                  },
                ),
                ListTile(
                  title: const Text(
                    "Home Page",
                    style: TextStyle(color: secondaryColor, fontSize: 15),
                  ),
                  trailing: const Icon(Icons.home, color: secondaryColor),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    navigator.pushReplacementNamed(HomePage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                title: const Center(
                  child: Text("Admin Playing Page"),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AdminPlayPage.routeName);
                },
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                title: const Center(
                  child:  Text("Admin Upcoming Page"),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AdminUpcomingPage.routeName);
                },
              ),
            ),
          ],
        ),
    );
  }
}
