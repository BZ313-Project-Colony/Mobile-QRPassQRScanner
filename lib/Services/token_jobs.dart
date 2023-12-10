import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_screen/Models/events_model.dart';
import 'package:login_screen/Services/api_service.dart';
import '../Constants/api_constants.dart';
import 'token_storage.dart';

class TokenEventListJobs extends TokenStorage {
  ApiService api = ApiService();
  //Tokeni Stroragedan aldık
  Future<String?> listToken() async {
    //ApiService.
    //Future<String?> tkn = ApiService.getStoredToken();
    String? token = await ApiService.getToken();

    print("------------------$token");
    return ApiService.getStoredToken();
  }

  //Listeyi olustumak icin fetchData() fonkisyonunu kulandık
  Future<List<EtkinlikModel>> getEventList() async {
    String? token = await listToken();
    List<dynamic> responseData = await fetchData(token ?? '');
    print("fetchdata token = $token");

    List<EtkinlikModel> eventList =
        responseData.map((e) => EtkinlikModel.fromMap(e)).toList();

    List<Map<String, dynamic>> eventListMap =
        eventList.map((e) => e.toMap()).toList();

    print("eventList: $eventListMap");
    //print("???? $eventList");
    return eventList;
  }
}

Future<List> fetchData(String token) async {
  try {
    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.eventListEndpoint),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List<dynamic>;

      // Doğrudan EtkinlikModel listesini oluştur
      List<EtkinlikModel> eventList =
          responseData.map((map) => EtkinlikModel.fromMap(map)).toList();

      return responseData;
    } else if (response.statusCode == 401) {
      print('yetki yok');
      return [];
    } else {
      print('API bozuk: ${response.reasonPhrase}');
      return [];
    }
  } catch (error) {
    print('API isteği başarısız: $error');
    return [];
  }
}
