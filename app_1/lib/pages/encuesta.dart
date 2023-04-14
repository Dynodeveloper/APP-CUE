import 'package:flutter/material.dart';

class Encuesta extends StatefulWidget {
  const Encuesta({Key? key}) : super(key: key);

  @override
  _EncuestaState createState() => _EncuestaState();
}

class _EncuestaState extends State<Encuesta> {
  int _valorPregunta1 = 3; // Valor inicial de la pregunta 1
  int? _valorPregunta2; // Valor seleccionado de la pregunta 2
  String? _valorPregunta3; // Valor ingresado en la pregunta 3

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pregunta 1: ¿Cómo te sientes hoy?',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.sentiment_very_satisfied),
                  onPressed: () => setState(() => _valorPregunta1 = 5),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_satisfied),
                  onPressed: () => setState(() => _valorPregunta1 = 4),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_neutral),
                  onPressed: () => setState(() => _valorPregunta1 = 3),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_dissatisfied),
                  onPressed: () => setState(() => _valorPregunta1 = 2),
                ),
                IconButton(
                  icon: const Icon(Icons.sentiment_very_dissatisfied),
                  onPressed: () => setState(() => _valorPregunta1 = 1),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Pregunta 2: ¿Cuál es tu color favorito?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            RadioListTile<int>(
              title: const Text('Rojo'),
              value: 1,
              groupValue: _valorPregunta2,
              onChanged: (value) => setState(() => _valorPregunta2 = value),
            ),
            RadioListTile<int>(
              title: const Text('Azul'),
              value: 2,
              groupValue: _valorPregunta2,
              onChanged: (value) => setState(() => _valorPregunta2 = value),
            ),
            RadioListTile<int>(
              title: const Text('Verde'),
              value: 3,
              groupValue: _valorPregunta2,
              onChanged: (value) => setState(() => _valorPregunta2 = value),
            ),
            RadioListTile<int>(
              title: const Text('Amarillo'),
              value: 4,
              groupValue: _valorPregunta2,
              onChanged: (value) => setState(() => _valorPregunta2 = value),
            ),
            RadioListTile<int>(
              title: const Text('Morado'),
              value: 5,
              groupValue: _valorPregunta2,
              onChanged: (value) => setState(() => _valorPregunta2 = value),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pregunta 3: ¿Cuál es tu opinión acerca de esta encuesta?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Escribe tu opinión aquí',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _valorPregunta3 = value),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Enviar'),
              onPressed: () {
                // Aquí se puede agregar la lógica para enviar las respuestas de la encuesta
              },
            ),
          ],
        ),
      ),
    );
  }
}
