import 'package:acrgis_app/pages/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:acrgis_app/pages/HomePage.dart';
import 'package:acrgis_app/pages/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //inicializar app de firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }


  @override //fondo base
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 43, 43), //color de fondo
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _googleSignIn = GoogleSignIn();
  bool _isLoading = false;

  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Autenticación con éxito
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      // Manejo de errores
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  //Login Function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "User-not-found") {
        print("No se encontró un usuario con ese email");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    //crear controlador de texto ingresado
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                'assets/Logo.png',
                width: 170,
                height: 140,
              )),
              Center(
                child: const Text(
                  "Bienvenidx!",
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255), //color texto principal
                    fontSize: 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "email",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.mail,
                      color: Color.fromARGB(255, 14, 106, 167)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock,
                      color: Color.fromARGB(255, 14, 106, 167)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 13.5),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Forgot_Password()));
                  },
                  child: const Text(
                    'olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.blueGrey),
                  )),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.all(0.2),
                width: double.infinity,
                child: SizedBox(
                  height: 50.0,
                  child: RawMaterialButton(
                    fillColor:
                        Color.fromARGB(255, 24, 54, 84), //color boton login
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    onPressed: () async {
                      //testeo de autenticacion
                      User? user = await loginUsingEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                      print(user);
                      if (user != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.all(0.2),
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor:
                      Color.fromARGB(255, 24, 54, 84), //color boton sign in
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () {
                    // Navigate to sign up screen
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0.2),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    _signInWithGoogle();
                    final googleUser = await _googleSignIn.signIn();
                    if (googleUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      // Successfully authenticated with Google
                      // TODO: Add code to handle authenticated user
                    }
                  },
                  icon: Image.asset(
                    'assets/google.png',
                    height: 24.0,
                  ),
                  label: const Text("Sign in with Google"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 24, 54, 84),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))));
  }
}
