import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasesServices {
  final db = FirebaseFirestore.instance;

  addData(Map<String, dynamic> data) async {
    try {
      await db.collection("movies").add(data);
      print("Data berhasil ditambahkan");
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> read() async {
    try {
      final querySnapshot = await db.collection("movies").get();
      print("Data berhasil diambil");
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error reading data: $e');
      return [];
    }
  }

  getMoviesStream() {}
}
