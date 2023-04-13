import 'package:flutter/material.dart';

class ExpoSIG extends StatefulWidget {
  const ExpoSIG({Key? key}) : super(key: key);

  @override
  _ExpoSIGState createState() => _ExpoSIGState();
}

class _ExpoSIGState extends State<ExpoSIG> {
  double _scale = 1.0;
  double _previousScale = 1.0;

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
      onScaleStart: (details) {
        setState(() {
          _previousScale = _scale;
        });
      },
      onScaleUpdate: (details) {
        setState(() {
          _scale = _previousScale * details.scale;
        });
      },
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.1,
        maxScale: 2.0,
        child: Stack(
          children: [
            // Widget de tu plano o mapa
            Image(
              image: AssetImage('assets/Plano.png'),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
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
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ),
            // Ventana emergente 2
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
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        scaleEnabled: true,
        panEnabled: true,
      ),
    );
  }
}
