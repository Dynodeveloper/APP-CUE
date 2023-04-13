import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: SignUpScreen(),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario creado con éxito'),
        ),
      );
      Navigator.pop(context); // Vuelve a la pantalla de inicio de sesión
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 43, 43, 43),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        title: Text('Registrarse'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 45.0,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Email",
                prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Contraseña",
                prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Registrarse'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 14, 106, 167),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
          ],
        ),
      ),
    );
  }
}
