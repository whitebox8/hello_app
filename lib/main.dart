import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokemonScreen(),
    );
  }
}

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;

  final TextEditingController controller = TextEditingController();

  Future<void> fetchPokemon(String pokemon) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemon');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          pokemonData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('No encontrado');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        pokemonData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1511512578047-dfb367046420 ',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Pokédex',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ingresa nombre o número (ej: pikachu o 25)',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      fetchPokemon(controller.text.toLowerCase());
                    }
                  },
                  child: const Text('Buscar Pokémon'),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 20),
                if (pokemonData != null && !isLoading)
                  Column(
                    children: [
                      Text(
                        pokemonData!['name'].toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.network(
                        pokemonData!['sprites']['front_default'],
                        height: 120,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Altura: ${pokemonData!['height']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Peso: ${pokemonData!['weight']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                if (pokemonData == null && !isLoading)
                  const Text(
                    'No se encontró el Pokémon',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
