import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

//acá se crea el header del drawer

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    final String? name = FirebaseAuth.instance.currentUser?.displayName; //se llama a la informacion de el usuario en firebase
    final String? photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    final String? email = FirebaseAuth.instance.currentUser?.email;
    return Container( //estilo del drawer
      color: Color.fromARGB(255, 73, 89, 112),
      width: double.infinity,
      height: 255,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         mainAxisSize: MainAxisSize.min,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 73, 89, 112)),
            accountEmail: Text(email ?? 'email de usuario'), //muestra el email del usuario
            currentAccountPicture:  CircleAvatar(
              backgroundImage: NetworkImage(photoUrl ?? ''), //se llama la imagen de perfil encontrada en el perfil de firebase
            ),
             accountName: Text(name ?? 'Nombre de usuario'), //se llama al nombre del usuario en firebase
          ),
        ],
      ),
    );
  }
}

