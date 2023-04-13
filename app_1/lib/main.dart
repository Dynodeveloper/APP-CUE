
import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //elimina mensaje de debug
      home: const SplashScreen(title: 'Login',), //inicializa la splashScreen (pages/splash_Screen)
    );
  }
}


