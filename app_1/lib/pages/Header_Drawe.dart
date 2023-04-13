import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 43, 43, 43),
      width: double.infinity,
      height: 255,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         mainAxisSize: MainAxisSize.min,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 43, 43, 43)),
            accountEmail: const EmailWidget(),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://img-15.stickers.cloud/packs/ebd6837a-ec38-4380-b602-424eba685f7e/webp/0cf03a16-93ae-4a68-bbf8-92a0f92b9fe3.webp',
              ),
            ),
            accountName: null,
          ),
        ],
      ),
    );
  }
}


class EmailWidget extends StatelessWidget {
  const EmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Text(user?.email ?? 'Correo electrónico');
  }
}