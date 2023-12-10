// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/api_constants.dart';

class ApiService {
  static Future<void> login(String username, int password) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint),
      headers: headers,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successful login, handle the response as needed
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String? token = data['token'];

      // Store the token locally
      if (token != null) {
        await _storeToken(token);
        print('******************** $token');
      }
    } else {
      // Handle Login failure
      throw Exception('Login Failed: ${response.statusCode}');
    }
  }

  static Future<String?> getToken() async {
    return getStoredToken();
  }

  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
