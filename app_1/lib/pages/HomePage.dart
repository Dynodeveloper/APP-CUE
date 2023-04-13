import 'package:acrgis_app/pages/Header_Drawe.dart';
import 'package:acrgis_app/pages/Login.dart';
import 'package:acrgis_app/pages/agenda.dart';
import 'package:acrgis_app/pages/encuesta.dart';
import 'package:acrgis_app/pages/exposig.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth =
    FirebaseAuth.instance; //variables respecto a autenticacion en firebase
User? user = _auth.currentUser; //usuario
String name = user?.displayName ?? ""; //nombre
String email = user?.email ?? ""; //email
final String? photoUrl = FirebaseAuth.instance.currentUser?.photoURL; //foto

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), //recibe cambios en estado de la sesion
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        final bool isLoggedIn = snapshot.hasData;

        return MaterialApp(
          title: 'ArcgisAPP',
          home: isLoggedIn
              ? HomePage()
              : LoginPage(), //si se encuentra logeado envia a esta pagina, de lo contrario regresa al incio de sesion
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum DrawerSections {
  //definicio de las secciones del drawer
  Inicio,
  ExpoSIG,
  Agenda,
  notes,
  settings,
  notifications,
  Encuesta,
  Logout,
}

class _HomePageState extends State<HomePage> {
  double profileHeight = 144; //definicio de variables utilizadas despues
  final double coverHeight = 200;
  var currentPage = DrawerSections.Inicio; //define la pagina actual inicial

  Future<void> _signOut() async {
    //funcion futura para el boton de sign out
    await _auth.signOut(); // Cerrar sesión en Firebase Auth
    Navigator.pushReplacement(
      // Navegar a la página de inicio de sesión
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget CoverImage() => Container(
        //widget encargado de la imagen de fondo de la pagina principal
        color: Colors.grey,
        child: Image.network(
          'https://www.esri.com/content/dam/esrisites/en-us/media/social-media/social-sharing-image-default.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget ProfileImage() => CircleAvatar(
        //widget encargado de la la imagen de perfil encontrada en la pagina principal
        radius: profileHeight / 2,
        backgroundColor: Colors.blueGrey,
        backgroundImage: NetworkImage(photoUrl ??
            ''), //linkeo a la imagen existente en la cuenta del usuario (google o microsoft)
      );

  Widget buildTop() {
    //widget encargado del contenido de la parte superior de la pagina de usuario o pagina principal
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
    //widget encargado del contenido de usuario en la pagina principal
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              email,
            ),
          ),
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
      //realiza los condicionales y funciones de cada seccion del drawer
      user = _auth.currentUser;
      container = Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(), //llama al widget encargado de la parte superior
            buildContent(), //llama al widget encargado del contenido
          ],
        ),
      );
    } else if (currentPage == DrawerSections.ExpoSIG) {
      container = ExpoSIG(); //redirecciona a la pagina Exposig
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
    //si se desea agregar  otra pagina se realizaria asi:
    //} else if (currentPage == DrawerSections.Logout) {container = "funcion o clase a llamar"();}

    return Scaffold(
      //diseño de el app drawer
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
    //crea el widget de la vista del drawer
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(
              1,
              "Inicio",
              Icons.home, //define nombre e icono de la opcion
              currentPage == DrawerSections.Inicio
                  ? true
                  : false), //se asegura si la pagina actual pertenece a una seccion del drawer
          menuItem(2, "ExpoSIG", Icons.workspaces_filled,
              currentPage == DrawerSections.ExpoSIG ? true : false),
          Divider(),
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
          //si se desea agregar otra pagina tambien e debo agregar acá siguiendo la logica y el numero del anterior algo asi:
          // menuItem(9, "nuevapagina", Icons.feedback_outlined,currentPage == DrawerSections.nuevapagina ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    //agrega el estilo de seleccionado a la opcion actual del drawer
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
            }
            //si se desea agregar una nueva pagina se debe agregar debajo de esta y encima de la de deslogeo de esta forma:
            //else if (id == 8 "se cambiaria este numero acá y en el drawerlist anterior y se modificarian los numeros siguientes si asi corresponde") { currentPage = DrawerSections.otrapagina;}
            
            else if (id == 8) {
              //si se presiona la opcion de deslogeo regresa a la pagina de inicio de sesion y deslogea la cuenta
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
