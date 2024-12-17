import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryServices {
  final String _historyKey = 'history_movies';
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getHistoryMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil daftar history yang ada
    List<String> historyMovies = prefs.getStringList(_historyKey) ?? [];
    return historyMovies
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

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

  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    print('History cleared');
  }
}
