import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Usuario { //crear clase usuario
  int id;
  String name, email, photo;

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });
}

class FactoryData {    //Se crea la clase con los datos de los invitados
  static List<Usuario> users = [
    Usuario(
      id: 1,
      name: "Milena Catillo",
      email: "milena.@gmail.com",
      photo:
      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    ),
    Usuario(
      id: 2,
      name: "Leidy Garcia",
      email: "leidy@hotmail.com",
      photo:
      "https://images.unsplash.com/photo-1532074205216-d0e1f4b87368?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d29tYW4lMjBwcm9maWxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
    ),
    Usuario(
      id: 3,
      name: "Orlando Vargas",
      email: "orlando@hotmail.com",
      photo:
      "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
    ),
    Usuario(
      id: 4,
      name: "Duvan Zapata",
      email: "duvan@gmail.com",
      photo:
      "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    ),
    Usuario(
      id: 5,
      name: "Lina Caicedo",
      email: "lina@gmail.com",
      photo:
      "https://i.pinimg.com/236x/a6/29/02/a62902c0458a23d705492bb701371a43--cool-wallpapers-for-iphone-wallpaper-for-iphone.jpg",
    ),
    Usuario(
      id: 6,
      name: "Carlos Villagran",
      email: "carlos@gmail.com",
      photo:
      "https://i.pinimg.com/originals/2a/36/ad/2a36add932afa93c3c332b64e6298f2f.jpg",
    ),
    Usuario(
      id: 7,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 7,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 7,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 7,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 7,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 8,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 9,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 10,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 11,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",
    ),
    Usuario(
      id: 12,
      name: "Petra Gómez",
      email: "petrica@hotmail.com",
      photo: "https://www.adobe.com/express/create/media_1c6fc2df39cf891716e5986fbfed3870ea73e4a81.jpeg?width=400&format=jpeg&optimize=medium",

    ),

  ];
}

class MyLoading extends StatelessWidget { //se crear clase para la funcion de cargar
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
        ),
      ),
    );
  }
}

class Invitados extends StatefulWidget {
  const Invitados({Key? key}) : super(key: key);

  @override
  State<Invitados> createState() => _InvitadosState();
}

class _InvitadosState extends State<Invitados> {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Usuario> users = [];

  getUsers() async {
    setState(() {
      users.clear();
    });
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      users.addAll(FactoryData.users);
    });
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        header: WaterDropHeader(
          waterDropColor: Colors.green.shade700,
          refresh: MyLoading(),
          complete: Container(),
          completeDuration: Duration.zero,
        ),
        onRefresh: () => getUsers(),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) =>
              item(users[index]),
        ),
      ),
    );
  }

  Widget item(Usuario user) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: user.photo,
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => SizedBox(
          height: 40,
          width: 40,
          child: MyLoading(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () {},
    );
  }
}