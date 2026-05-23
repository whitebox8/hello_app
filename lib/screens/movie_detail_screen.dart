import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, String> movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEN
            Image.network(
              movie['image']!,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TÍTULO
                  Text(
                    movie['title']!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // AÑO
                  Text(
                    'Año: ${movie['year']}',
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  // DIRECTOR
                  Text(
                    'Director: ${movie['director']}',
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  // GÉNERO
                  Text(
                    'Género: ${movie['genre']}',
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  // SINOPSIS
                  const Text(
                    'Sinopsis',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie['synopsis']!,
                    style: const TextStyle(fontSize: 16),
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
