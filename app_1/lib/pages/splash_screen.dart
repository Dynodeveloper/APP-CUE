import 'dart:async';
import 'package:flutter/material.dart';
import 'Login.dart'; //importa la pagina de Login

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState(){

    Timer(const Duration(seconds: 5), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>  LoginPage()), (route) => false); //al terminar envia a la pagina de Login (/pages/Login.dart)
      });
    });

    Timer(
        const Duration(milliseconds: 10),(){
      setState(() {
        _isVisible = true; // Now it is showing fade effect and navigating to Login page
      });
    }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 43, 43, 52),Color.fromARGB(255, 43, 43, 43), ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(157, 43, 43, 43),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(168, 0, 0, 0).withOpacity(0.3),
                    blurRadius: 1.0,
                    offset: const Offset(45.0, 3.0),
                    spreadRadius: 0.0,
                  )
                ]
            ),
            child: Center(
              child: ClipOval(
                child: Image.asset('assets/Logo_Splash.png', height: 300, width: 300,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}