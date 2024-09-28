import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String?> login(String username, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Mengembalikan token jika login berhasil
    } else {
      return null; // Mengembalikan null jika login gagal
    }
  }
}
