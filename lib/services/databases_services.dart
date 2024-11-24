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

  final collectionName = 'movies';
  Future<void> deleteAllDocuments(String collectionName) async {
    try {
      // Ambil referensi koleksi
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      // Ambil semua dokumen dalam koleksi
      QuerySnapshot snapshot = await collectionRef.get();

      // Iterasi melalui dokumen dan hapus satu per satu
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print("Semua dokumen dalam koleksi '$collectionName' berhasil dihapus.");
    } catch (e) {
      print("Terjadi kesalahan saat menghapus dokumen: $e");
    }
  }

  Future<void> refresh() async {
    try {
      await deleteAllDocuments(collectionName);
      print("Koleksi berhasil di-refresh.");
    } catch (e) {
      print("Terjadi kesalahan saat me-refresh koleksi: $e");
    }
  }
}
