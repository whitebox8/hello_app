import 'package:cloud_firestore/cloud_firestore.dart';

class MovieService {
  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('movies');

  Future<void> addMovie({
    required String title,
    required String year,
    required String director,
    required String genre,
    required String synopsis,
    required String image,
  }) async {
    await moviesCollection.add({
      'title': title,
      'year': year,
      'director': director,
      'genre': genre,
      'synopsis': synopsis,
      'image': image,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getMovies() {
    return moviesCollection.snapshots();
  }

  Future<void> deleteMovie(String id) async {
    await moviesCollection.doc(id).delete();
  }
}
