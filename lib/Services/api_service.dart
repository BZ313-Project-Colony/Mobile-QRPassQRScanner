// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/api_constants.dart';
import '../Models/participant_model.dart';

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
  static Future<List<Map<String, dynamic>>> getTicketsOfEvent(int eventId) async {
    final String? token = await getToken();
    if (token == null) {
      throw Exception('User not logged in');
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/v1/events/$eventId/tickets'), // Corrected the endpoint construction
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, dynamic>> participants = List<Map<String, dynamic>>.from(responseData);
      return participants;
    } else {
      throw Exception('Failed to load participants: ${response.statusCode}');
    }
  }
  static Future<List<ParticipantModel>> getParticipantsForEvent(int eventId) async {
    final String endpoint = ApiConstants.getTicketsOfEventEndpoint(eventId);
    final String? token = await getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + endpoint),
      headers: headers,
    );

    print('Response Body: ${response.body}'); // Analyze data format

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.body.codeUnits)) as List<dynamic>;

      final List<ParticipantModel> participants = data
          .map((participantJson) {
        if (participantJson is Map<String, dynamic>) {
          return ParticipantModel.fromJson({
            'name': participantJson['name'] ?? '',
            'surname': participantJson['surname'] ?? '',
            'email': participantJson['email'] ?? '',
            'isConfirmed': participantJson['isConfirmed'] ?? false,
          });
        } else {
          throw Exception('Invalid participant data: ${participantJson.runtimeType}');
        }
      })
          .toList();

      return participants;
    } else {
      throw Exception('Failed to load participants: ${response.statusCode}');
    }
  }
}

