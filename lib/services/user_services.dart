import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addProfilImage(String url) async {
    await userCollection.doc(uid).set({
      'profilImage': url,
    });
  }

  // Add history
  Future<void> addHistory(
      Map<String, dynamic> movie, Timestamp timestamp) async {
    final querySnapshot = await userCollection
        .doc(uid)
        .collection('history')
        .where('judul', isEqualTo: movie['judul'])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('Movie sudah ada di history');
      return;
    }

    await userCollection.doc(uid).collection('history').add({
      'judul': movie['judul'],
      'watchedAt': timestamp,
    });

    print('Added to favorites: ${movie['judul']}');
  }

  // Read history
  Stream<QuerySnapshot> getHistory() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history')
        .snapshots();
  }

  // Clear history
  Future<void> clearHistory() async {
    final historyDocs =
        await userCollection.doc(uid).collection('history').get();
    for (final doc in historyDocs.docs) {
      await doc.reference.delete();
    }
  }

  // Add favorite
  Future<void> addFav(Map<String, dynamic> movie) async {
    final querySnapshot = await userCollection
        .doc(uid)
        .collection('favorites')
        .where('judul', isEqualTo: movie['judul'])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('Movie sudah ada di favorites');
      return;
    }

    await userCollection.doc(uid).collection('favorites').add({
      'judul': movie['judul'],
      // 'poster_potrait': movie['poster_potrait'],
    });

    print('Added to favorites: ${movie['judul']}');
  }

  // Read favorites
  Future<List<Map<String, dynamic>>> getFavMovies() async {
    final querySnapshot =
        await userCollection.doc(uid).collection('favorites').get();

    return querySnapshot.docs.map((doc) {
      return {
        'judul': doc['judul'],
        'poster_potrait': doc['poster_potrait'],
      };
    }).toList();
  }

  // Remove favorite
  Future<void> removeFav(String title) async {
    final querySnapshot = await userCollection
        .doc(uid)
        .collection('favorites')
        .where('judul', isEqualTo: title)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('Movie tidak ditemukan di favorites');
      return;
    }

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Removed from favorites: $title');
  }

  Future<bool> isMovieFav(Map<String, dynamic> movie) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = uid;
    DocumentReference userFavsRef = firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(movie['judul']);

    DocumentSnapshot snapshot = await userFavsRef.get();

    return snapshot.exists;
  }
}
