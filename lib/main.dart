import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼️ IMAGEN DE FONDO
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌑 CAPA OSCURA (para que el texto se vea mejor)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // 📱 CONTENIDO
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // NOMBRE DE LA APP
                Text(
                  'Diseño de aplicaciones móviles',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // MENSAJE
                Text(
                  '3.5 Home screen con Layouts',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
