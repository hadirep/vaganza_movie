import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vaganza_movie/common/styles.dart';
import 'package:vaganza_movie/data/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static const String routeName = 'register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;
  String? _registrationError; // Error message for registration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          elevation: 1,
          title: const Text(
            'Daftar Vaganza Movie',
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
            const SizedBox(height: 8.0),
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
            _registrationError != null
                ? Text(
              _registrationError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            )
                : Container(),
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
                  _registrationError = null; // Reset the registration error
                });
                try {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  // Validate email format
                  if (!isValidEmail(email)) {
                    _showErrorSnackbar('The email address format is not valid');
                    setState(() {
                      _isLoading = false;
                    });
                    return; // Don't proceed with registration
                  }

                  await AuthService().register(email, password, context);
                } catch (e) {
                  if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
                    _showErrorSnackbar('Your account has already been created');
                  } else {
                    _showErrorSnackbar('An error occurred while creating the account');
                  }
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                'Sudah punya akun?',
                style: TextStyle(color: buttonColor),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: buttonColor,
                backgroundColor: primaryColor, // Warna teks pada tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Mengatur border radius
                  side: const BorderSide(color: buttonColor), // Mengatur border dengan warna biru
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Daftar Sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
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
