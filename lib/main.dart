import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PantallaEjemplo(),
    );
  }
}

class PantallaEjemplo extends StatelessWidget {
  const PantallaEjemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets básicos')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TEXT
          const Text(
            'Ejemplo de Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('A'),
              Text('B'),
              Text('C'),
            ],
          ),

          const SizedBox(height: 20),

          // CONTAINER
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orange,
            child: const Text('Container'),
          ),

          const SizedBox(height: 20),

          // STACK
          Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 100, height: 100, color: Colors.blue),
              const Text(
                'Stack',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
