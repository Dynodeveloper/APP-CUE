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
      title: 'Restablecer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reinicio de contraseña'),
        ),
        body: Forgot_Password(),
      ),
    );
  }
}

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
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
          content: Text('Correo enviado con exito'),
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
        title: Text('Restablecer'),
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
            ElevatedButton(
              onPressed: _register,
              child: Text('Reestablecer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 14, 106, 167),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
