import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasesServices {
  final db = FirebaseFirestore.instance;

  // create() {
  //   db.collection('movies').add({
  //     'title': 'The Shawshank Redemption',
  //     'description': 'Twojjahshahs',
  //   });
  // }

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

  // read() async {
  //   try {
  //     await db.collection("movies").get().then((event) {
  //       for (var doc in event.docs) {
  //         print("${doc.id} => ${doc.data()}");
  //       }
  //     });
  //   } catch (e) {
  //     print('Error reading data: $e');
  //   }
  // }

  getMoviesStream() {}
}
