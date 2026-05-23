import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestFirestoreScreen extends StatelessWidget {
  const TestFirestoreScreen({super.key});

  Future<void> testConnection() async {
    await FirebaseFirestore.instance.collection('test').add({
      'mensaje': 'Firebase conectado correctamente',
      'fecha': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba Firebase'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await testConnection();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Datos enviados a Firebase'),
              ),
            );
          },
          child: const Text('Probar conexión'),
        ),
      ),
    );
  }
}
