import 'package:flutter/material.dart';
import 'movie_detail_screen.dart';
import 'admin_screen.dart';
import '../services/movie_service.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieService movieService = MovieService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminScreen(),
                ),
              );
            },
            icon: const Icon(Icons.admin_panel_settings),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: movieService.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error cargando películas',
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final movies = snapshot.data!.docs;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(
                    movie['image'],
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie['title'],
                  ),
                  subtitle: Text(
                    movie['genre'],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movie: {
                            'title': movie['title'],
                            'year': movie['year'],
                            'director': movie['director'],
                            'genre': movie['genre'],
                            'synopsis': movie['synopsis'],
                            'image': movie['image'],
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
