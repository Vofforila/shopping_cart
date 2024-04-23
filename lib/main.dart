// Local Packages
import 'package:shopping_cart/data/app_state.dart';
import 'package:shopping_cart/pages/login.dart';
import 'package:shopping_cart/pages/mainpage.dart';

// Imported Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*Themes:
Main Blue: 32, 30, 80, 69
Main Text: 0, 0, 0, 0
Text Variant White: 223, 248, 235 , 3
Object Green: 194,255,133,100
Second Brown: 80, 31, 30, 69
*/

void main() async {
  // Used for fire_base_auth
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(),
        home: const LoginPage(),
      ),
    );
  }
}
