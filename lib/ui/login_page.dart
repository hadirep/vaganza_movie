import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/auth_service.dart';
import 'package:vaganza_movie/ui/reset_password_page.dart';
import 'package:vaganza_movie/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          elevation: 1,
          title: const Text(
            'Masuk ke Vaganza Movie',
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColor,
          leading: IconButton(
            color: secondaryColor,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("EMAIL", style: TextStyle(color: buttonColor)),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(),
              const SizedBox(height: 20),
              const Text("PASSWORD", style: TextStyle(color: buttonColor)),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Lupa Password ?",style: TextStyle(color: buttonColor)),
                  TextButton(
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, ResetPasswordPage.routeName),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              MaterialButton(
                color: buttonColor,
                textTheme: ButtonTextTheme.primary,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    await AuthService().login(email, password, context);
                  } catch (e) {
                    if (e is FirebaseAuthException &&
                        e.code == 'wrong-password') {
                      _showErrorSnackbar('The password you entered is incorrect');
                    } else {
                      _showErrorSnackbar(
                          'The email or password you entered is incorrect');
                    }
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: const Text('Masuk'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonColor,
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: buttonColor),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await _signInWithGoogle();
                  } catch (e) {
                    print('Error signing in with Google : $e');
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Row(
                  children:[
                    Image.asset('assets/google.png', width: 30, height: 30,),
                    const SizedBox(width: 50),
                    const Text("Masuk dengan Google"),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Belum punya akun?',
                  style: TextStyle(color: buttonColor),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonColor,
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: buttonColor),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.routeName);
                },
                child: const Text('Daftar Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Login dengan Google dibatalkan
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await AuthService().signInWithCredential(credential, context); // Gantilah ini dengan metode yang sesuai di AuthService Anda
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle error
    }
  }

  void _showErrorSnackbar(String errorMessage) {
    final snackbar = SnackBar(content: Text(errorMessage));
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
