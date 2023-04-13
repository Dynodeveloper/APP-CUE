import 'package:flutter/material.dart';


class ExpoSIG extends StatefulWidget {
  const ExpoSIG({Key? key}) : super(key: key);

  @override
  _ExpoSIGState createState() => _ExpoSIGState();
}

//pagina de ExpoSIG

class _ExpoSIGState extends State<ExpoSIG> {
  final icono1 = Icons.location_on;
  final icono2 = Icons.location_on;

  Widget _buildDialog(BuildContext context, String title, String description,
      String imageAsset) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageAsset),
          SizedBox(height: 16.0),
          Text(description),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cerrar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          // Widget de tu plano o mapa
          InteractiveViewer(
            child: Image(
              image: AssetImage('assets/Plano.png'),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Ventana emergente 1
          Positioned(
            left: 50,
            top: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 1',
                    'Descripción de la ventana emergente 1',
                    'assets/imagen1.png',
                  ),
                );
              },
              child: Icon(
                icono1,
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
          // Ventana emergente 2
          Positioned(
            right: 120,
            bottom: 120,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => _buildDialog(
                    context,
                    'Título de la ventana emergente 2',
                    'Descripción de la ventana emergente 2',
                    'assets/imagen2.png',
                  ),
                );
              },
              child: Icon(
                icono2,
                size: 50,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
