import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FavMoviesServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Map<String, dynamic>>> getFavMovies() async {
    try {
      QuerySnapshot favSnapshot =
          await userCollection.doc(uid).collection('favorites').get();

      List<Map<String, dynamic>> favMovies = [];

      for (var favDoc in favSnapshot.docs) {
        String title = favDoc['judul'];
        QuerySnapshot movieSnapshot = await _firestore
            .collection('movies')
            .where('judul', isEqualTo: title)
            .get();

        if (movieSnapshot.docs.isNotEmpty) {
          favMovies
              .add(movieSnapshot.docs.first.data() as Map<String, dynamic>);
        }
      }

      return favMovies;
    } catch (e) {
      print('Error fetching favorite movies with details: $e');
      return [];
    }
  }

  Future<bool> isMovieFav(Map<String, dynamic> movie) async {
    try {
      QuerySnapshot favSnapshot =
          await userCollection.doc(uid).collection('favorites').get();

      return favSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking if movie is favorite: $e');
      return false;
    }
  }
}
