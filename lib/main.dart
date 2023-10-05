import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/model/playing_model.dart';
import 'package:vaganza_movie/ui/account_page.dart';
import 'package:vaganza_movie/ui/admin/admin_play_page.dart';
import 'package:vaganza_movie/ui/admin/admin_upcoming_page.dart';
import 'package:vaganza_movie/ui/home_page.dart';
import 'package:vaganza_movie/ui/login_page.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart';
import 'package:vaganza_movie/ui/register_page.dart';
import 'package:vaganza_movie/ui/reset_password_page.dart';
import 'package:vaganza_movie/ui/admin/admin_page.dart';
import 'package:vaganza_movie/widget/movie_screen.dart';
import 'package:vaganza_movie/widget/widget_location.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        AccountPage.routeName: (context) => const AccountPage(),
        AdminPage.routeName: (context) => const AdminPage(),
        AdminPlayPage.routeName: (context) => const AdminPlayPage(),
        AdminUpcomingPage.routeName: (context) => const AdminUpcomingPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        ResetPasswordPage.routeName: (context) => const ResetPasswordPage(),
        WidgetLocation.routeName: (context) => const WidgetLocation(),
        MovieScreen.routeName: (context) => const MovieScreen(),
        PlayingDetailPage.routeName: (context) => PlayingDetailPage(
          playingModel: ModalRoute.of(context)!.settings.arguments as PlayingModel,
        ),
      },
    );
  }
}