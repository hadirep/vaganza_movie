import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/model/play_model.dart';
import 'package:vaganza_movie/ui/home_page.dart';
import 'package:vaganza_movie/ui/login_page.dart';
import 'package:vaganza_movie/ui/playing_detail_page.dart';
import 'package:vaganza_movie/ui/register_page.dart';
import 'package:vaganza_movie/ui/reset_password_page.dart';

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
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        ResetPasswordPage.routeName: (context) => const ResetPasswordPage(),
        HomePage.routeName: (context) => const HomePage(),
        PlayingDetailPage.routeName: (context) => PlayingDetailPage(
          place: ModalRoute.of(context)!.settings.arguments as PlayModel,
        ),
      },
    );
  }
}