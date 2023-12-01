import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../Constants/api_constants.dart';

class ApiService {
  static Future<void> login(String username, int password) async {
    var logger = Logger(
      filter: DevelopmentFilter(),
    );

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
      print('Login Successful: $data');
      logger.i('Login Successful: $data');
      // Navigate to the next screen or perform other actions
    } else {
      // Handle Login failure
      print('Login Failed: ${response.statusCode}');
      print('Login Failed: ${response.body}');
      logger.e('Login Failed: ${response.statusCode}');
    }
  }
}
