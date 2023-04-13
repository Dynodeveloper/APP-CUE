import 'package:acrgis_app/pages/Header_Drawe.dart';
import 'package:acrgis_app/pages/Login.dart';
import 'package:acrgis_app/pages/agenda.dart';
import 'package:acrgis_app/pages/encuesta.dart';
import 'package:acrgis_app/pages/exposig.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        final bool isLoggedIn = snapshot.hasData;

        return MaterialApp(
          title: 'ArcgisAPP',
          home: isLoggedIn ? HomePage() : LoginPage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double profileHeight = 144;
  final double coverHeight = 200;
  var currentPage = DrawerSections.Inicio;
  User? user;

  Future<void> _signOut() async {
    await _auth.signOut(); // Cerrar sesión en Firebase Auth
    Navigator.pushReplacement(
      // Navegar a la página de inicio de sesión
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget CoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://www.esri.com/content/dam/esrisites/en-us/media/social-media/social-sharing-image-default.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget ProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.blueGrey,
        backgroundImage: NetworkImage(
            'https://img-15.stickers.cloud/packs/ebd6837a-ec38-4380-b602-424eba685f7e/webp/0cf03a16-93ae-4a68-bbf8-92a0f92b9fe3.webp'),
      );
  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: CoverImage(),
        ),
        Positioned(
          top: top,
          child: ProfileImage(),
        )
      ],
    );
  }

  Widget buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Juan gutierrez', style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),)),
          const SizedBox(
            height: 16,
          ),
          Center(child: Text('Integrante de semillero')),
          const SizedBox(
            height: 16,
          ),
          Text(
            'About',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Text('loremasjaksjkajksjadhhsdbuedbbybecbecu'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.Inicio) {
      user = _auth.currentUser;
      container = Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            buildContent(),
          ],
        ),
      );
    } else if (currentPage == DrawerSections.ExpoSIG) {
      container = ExpoSIG();
    } else if (currentPage == DrawerSections.Agenda) {
      container = Agenda();
    } else if (currentPage == DrawerSections.notes) {
      //container = NotesPage();
    } else if (currentPage == DrawerSections.settings) {
      //container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      //container = NotificationsPage();
    } else if (currentPage == DrawerSections.Encuesta) {
      container = Encuesta();
    } else if (currentPage == DrawerSections.Logout) {
      container = LoginPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        title: Text("CUE APP"),
      ),
      body: container,
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Inicio", Icons.home,
              currentPage == DrawerSections.Inicio ? true : false),
          menuItem(2, "ExpoSIG", Icons.workspaces_filled,
              currentPage == DrawerSections.ExpoSIG ? true : false),
          menuItem(3, "Agenda", Icons.event,
              currentPage == DrawerSections.Agenda ? true : false),
          menuItem(4, "Notes", Icons.event,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          Divider(),
          menuItem(7, "Encuesta", Icons.check,
              currentPage == DrawerSections.Encuesta ? true : false),
          menuItem(8, "Sign Out", Icons.feedback_outlined,
              currentPage == DrawerSections.Logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Color.fromARGB(255, 14, 106, 167) : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.Inicio;
            } else if (id == 2) {
              currentPage = DrawerSections.ExpoSIG;
            } else if (id == 3) {
              currentPage = DrawerSections.Agenda;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.Encuesta;
            } else if (id == 8) {
              _signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  Inicio,
  ExpoSIG,
  Agenda,
  notes,
  settings,
  notifications,
  Encuesta,
  Logout,
}
//widgets pagina inicial

