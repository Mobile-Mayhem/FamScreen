import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryServices {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getHistMovies() async {
    try {
      QuerySnapshot favSnapshot =
          await userCollection.doc(uid).collection('history').get();

      List<Map<String, dynamic>> histMovies = [];

      for (var favDoc in favSnapshot.docs) {
        String title = favDoc['judul'];
        QuerySnapshot movieSnapshot = await _firestore
            .collection('movies')
            .where('judul', isEqualTo: title)
            .get();

        if (movieSnapshot.docs.isNotEmpty) {
          histMovies
              .add(movieSnapshot.docs.first.data() as Map<String, dynamic>);
        }
      }

      return histMovies;
    } catch (e) {
      print('Error fetching favorite movies with details: $e');
      return [];
    }
  }
}
