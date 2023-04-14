import 'package:acrgis_app/pages/Header_Drawe.dart';
import 'package:acrgis_app/pages/Login.dart';
import 'package:acrgis_app/pages/agenda.dart';
import 'package:acrgis_app/pages/encuesta.dart';
import 'package:acrgis_app/pages/exposig.dart';
import 'package:acrgis_app/pages/invitados.dart';
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
  Invitados,
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
        color: Color.fromARGB(255, 0, 0, 0),
        child: Image.network(
          'https://mms.businesswire.com/media/20220831005451/en/570118/23/esri_logo17.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget ProfileImage() => CircleAvatar(
        //widget encargado de la la imagen de perfil encontrada en la pagina principal
        radius: profileHeight / 2,
        backgroundColor: Colors.blueGrey,
        backgroundImage: NetworkImage(photoUrl ??''), //linkeo a la imagen existente en la cuenta del usuario (google o microsoft)
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

  Widget buildContent() { //define el widget encargado del contenido o informacion de usuario

    return Container(
        margin: EdgeInsets.symmetric(
            vertical: 2), // Agrega un margen vertical alrededor del contenedor

        height: 400,
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 13, 13, 13)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Color.fromARGB(255, 24, 54, 84)),
                    SizedBox(width: 10),
                    Text(
                      'Integrante del semillero',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correo electrónico:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        email,
                        style: TextStyle(
                          color: Color.fromARGB(225, 115, 168, 208),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Descripción:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Agente americano de la División de Operaciones de Seguridad (D.S.O.). Experto en combate físico, habilidoso en todo tipo de armas y en salir vivo de situaciones difíciles, en 1998 Leon fue un oficial de policía en el Departamento de Policía de Raccoon City (R.P.D.)',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.Inicio) {
      //realiza los condicionales y funciones de cada seccion del drawer
      user = _auth.currentUser;
      container = Scaffold(
        backgroundColor: Color.fromARGB(255, 73, 89, 112),
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
    } else if (currentPage == DrawerSections.Invitados) {
      container = Invitados();
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
        backgroundColor: Color.fromARGB(255, 73, 89, 112),
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
          menuItem(4, "Invitados", Icons.work,
              currentPage == DrawerSections.Invitados ? true : false),
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
      color: selected ? Color.fromARGB(255, 73, 89, 112) : Colors.transparent,
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
              currentPage = DrawerSections.Invitados;
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
