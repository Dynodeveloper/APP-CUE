import 'package:flutter/material.dart';

class Encuesta extends StatefulWidget {
  @override
  _EncuestaPageState createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<Encuesta> {
  late int _respuesta1 = 1;
  late String _respuesta2 = "";
  late String _respuesta3 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                'Encuesta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Que tan satifecho esta con los conferencistas?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      10,
                      (index) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _respuesta1 = index + 1;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: 40,
                          child: Text('${index + 1}'),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: _respuesta1 == index + 1
                              ? Color.fromARGB(255, 14, 106, 167)
                              : Color.fromARGB(255, 43, 43, 43),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Que pabellón le agradó mas?:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  RadioListTile(
                    title: Text('Pabellón 1'),
                    value: 'Pabellón 1',
                    groupValue: _respuesta2,
                    onChanged: (value) {
                      setState(() {
                        _respuesta2 = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Manga Site'),
                    value: 'Manga Site',
                    groupValue: _respuesta2,
                    onChanged: (value) {
                      setState(() {
                        _respuesta2 = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Geek Planet'),
                    value: 'Geek Planet',
                    groupValue: _respuesta2,
                    onChanged: (value) {
                      setState(() {
                        _respuesta2 = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Alguna recomendacion o comentario?:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    onChanged: (value) {
                      _respuesta3 = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Escriba su respuesta aquí',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 43, 43, 43)),
                    onPressed: () {
                      // Aquí puedes hacer lo que quieras con las respuestas
                      print('Respuesta 1: $_respuesta1');
                      print('Respuesta 2: $_respuesta2');
                      print('Respuesta 3: $_respuesta3');
                    },
                    child: Text('Enviar',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
