import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_screen/Models/events_model.dart';
import 'package:login_screen/Services/api_service.dart';
import '../Constants/api_constants.dart';
import 'token_storage.dart';

class TokenEventListJobs extends TokenStorage {
  static const String listToken1 = TokenStorage.tokenKey;
  //List<EtkinlikModel> eventList = [];
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
    List<EtkinlikModel> responseData = await fetchData(token ?? '');
    print("fetcdata token = $token");
    List<EtkinlikModel> eventList = responseData;
    print("???? $eventList");
    return eventList;
  }
}

Future<List<EtkinlikModel>> fetchData(String token) async {
  try {
    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.eventListEndpoint),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Başarılı bir cevap
      final responseData = json.decode(response.body);
      print("bu ne $responseData");
      return responseData;
    } else if (response.statusCode == 401) {
      // Token hatası (örneğin, token süresi dolmuş)
      print('yetkı yok');
      return [];
    } else {
      // Diğer hata durumları
      print('API bozuk: ${response.reasonPhrase}');
      return [];
    }
  } catch (error) {
    // Genel hata durumları
    print('API isteği başarısız: $error');
    return [];
  }
}
