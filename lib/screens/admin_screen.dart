import 'package:flutter/material.dart';
import '../services/movie_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final TextEditingController directorController = TextEditingController();

  final TextEditingController genreController = TextEditingController();

  final TextEditingController synopsisController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administración'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Año',
              ),
            ),
            TextField(
              controller: directorController,
              decoration: const InputDecoration(
                labelText: 'Director',
              ),
            ),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Género',
              ),
            ),
            TextField(
              controller: synopsisController,
              decoration: const InputDecoration(
                labelText: 'Sinopsis',
              ),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: 'URL imagen',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(

              onPressed: () async {
                await movieService.addMovie(
                  title: titleController.text,
                  year: yearController.text,
                  director: directorController.text,
                  genre: genreController.text,
                  synopsis: synopsisController.text,
                  image: imageController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Película guardada en Firebase'),
                  ),
                );

                titleController.clear();
                yearController.clear();
                directorController.clear();
                genreController.clear();
                synopsisController.clear();
                imageController.clear();
              },
              child: const Text('Agregar película'),
            ),
            const SizedBox(height: 30),

              StreamBuilder(
              stream: movieService.getMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text(
                    'Error cargando películas',
                  );
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final movies = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return Card(
                      child: ListTile(
                        title: Text(
                          movie['title'],
                        ),
                        subtitle: Text(
                          movie['genre'],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await movieService.deleteMovie(
                              movie.id,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )  
            

          ],
        ),
      ),
    );
  }
}
