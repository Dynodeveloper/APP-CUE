import 'package:flutter/material.dart';

class Encuesta extends StatefulWidget {
  @override
  _EncuestaPageState createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<Encuesta> {
  int _puntuacion = 3;
  String _opcionSeleccionada = '';
  TextEditingController _controller = TextEditingController();

  List<String> _opciones = [
    'Opción 1',
    'Opción 2',
    'Opción 3',
  ];

  void _enviarRespuestas() {
    // Aquí puedes agregar la lógica para enviar las respuestas de la encuesta
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Primera pregunta
            Text(
              '¿que te pareciò el evento?',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPuntuacionButton(1),
                _buildPuntuacionButton(2),
                _buildPuntuacionButton(3),
                _buildPuntuacionButton(4),
                _buildPuntuacionButton(5),
              ],
            ),
            SizedBox(height: 32),

            // Segunda pregunta
            Text(
              '¿Qué te gustaría hacer hoy?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            for (String opcion in _opciones)
              RadioListTile(
                title: Text(opcion),
                value: opcion,
                groupValue: _opcionSeleccionada,
                onChanged: (value) {
                  setState(() {
                    _opcionSeleccionada = value as String;
                  });
                },
              ),
            SizedBox(height: 32),

            // Tercera pregunta
            Text(
              '¿Algún comentario adicional?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe aquí tu comentario',
              ),
            ),
            SizedBox(height: 25),

            // Botón para enviar las respuestas
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 24, 54, 84)),
              onPressed: () { _enviarRespuestas();
                // Aquí puedes hacer lo que quieras con las respuestas
              },
              child: Text(
                'Enviar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildPuntuacionButton(int puntuacion) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _puntuacion = puntuacion;
        });
      },
      child: Column(
        children: [
          Icon(
            _puntuacion >= puntuacion
                ? Icons.sentiment_very_satisfied
                : Icons.sentiment_very_dissatisfied,
            size: 50,
            color: _puntuacion >= puntuacion ? Colors.green : Colors.red,
          ),
          Text(puntuacion.toString()),
        ],
      ),
    );
  }
}
