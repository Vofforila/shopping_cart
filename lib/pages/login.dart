// Local Packages
import 'package:shopping_cart/pages/mainpage.dart';
import 'package:shopping_cart/data/page_items.dart';

// Internet Packages
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Database references
final DatabaseReference usernameDatabase = FirebaseDatabase.instance.ref();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnackBar(String message) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _register(String username, String email, String password) {
    print('Username: $username');
    print('Email: $email');
    print('Password: $password');

    registerWithEmailAndPassword(email, password, username);
    _showSnackBar('Registration successful');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _openRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _usernameController =
            TextEditingController();
        final TextEditingController _emailController = TextEditingController();
        final TextEditingController _passwordController =
            TextEditingController();

        return AlertDialog(
          title: const Text('Register'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                String username = _usernameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;

                _register(username, email, password);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Handle the registered user
      User? user = userCredential.user;

      if (user != null) {
        user.updateDisplayName(username);
        print('User registered: ${user.uid}');
        usernameDatabase.child("usersData").child(user.uid).set(
          {
            'username': username,
            'uid': user.uid,
          },
        );
        _showSnackBar('Registration successful');
      }
    } catch (e) {
      // Handle registration errors
      print('Registration error: $e');
      _showSnackBar('Registration failed');
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Handle the signed-in user
      User? user = userCredential.user;
      if (user != null) {
        print('User signed in: ${user.uid}');
        _showSnackBar('Sign-in successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      _showSnackBar('Sign-in failed');
    }
  }

  Future<void> signInWithGoogle() async {

    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Handle the signed-in user
      User? user = userCredential.user;
      if (user != null) {
        print('User signed in: ${user.uid}');
        _showSnackBar('Sign-in successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      _showSnackBar('Sign-in failed');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['email']);

      // Create a Facebook Auth Credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      // Sign in to Firebase with the Facebook credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Handle the signed-in user
      User? user = userCredential.user;
      if (user != null) {
        print('User signed in: ${user.uid}');
        _showSnackBar('Sign-in successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      _showSnackBar('Sign-in failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: topNavigationBar(title: "Login Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromRGBO(32, 30, 80, 69),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _emailController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _passwordController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(194, 255, 133, 100)),
              ),
              onPressed: signInWithEmailAndPassword,
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(194, 255, 133, 100)),
              ),
              onPressed: _openRegistrationDialog,
              child: const Text('Register'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(194, 255, 133, 100)),
              ),
              onPressed: signInWithGoogle,
              child: const Text('Sign In with Google'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(194, 255, 133, 100)),
              ),
              onPressed: signInWithFacebook,
              child: const Text('Sign In with Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}
