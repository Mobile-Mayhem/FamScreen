import 'package:http/http.dart' as http;

class FilmApiServices {
  Future<void> sendTokenToLaravel(String firebaseToken) async {
    final url = 'http://127.0.0.1:8005/api/login';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $firebaseToken',
      },
    );

    if (response.statusCode == 200) {
      // Token JWT Laravel berhasil didapatkan
      print("Login successful: ${response.body}");
    } else {
      print("Login failed: ${response.statusCode}");
    }
  }
}
