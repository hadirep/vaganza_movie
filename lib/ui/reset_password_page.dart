import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String routeName = 'reset_password_page';

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
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
            'Reset Password',
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                  "Masukkan email yang digunakan pada saat registrasi."
                      "Kode verifikasi akan dikirimkan ke email tersebut."
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(),
            const SizedBox(height: 20),
            const Text("EMAIL", style: TextStyle(color: buttonColor)),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
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
                  
                  final account = await _auth.fetchSignInMethodsForEmail(email);
                  if (account.isNotEmpty) {
                    await _auth.sendPasswordResetEmail(email: email);
                    _showSnackbar('Password reset email has been sent. Please check your inbox');
                  } else {
                    _showSnackbar("I'm sorry, your email is not yet registered in our database");
                  }
                } catch (e) {
                  _showSnackbar('An error occurred while sending the password reset email: $e');
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    final snackbar = SnackBar(content: Text(message));
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
