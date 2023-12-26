import '../Services/api_service.dart';
import 'participants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'qr_scanner.dart';

class ParticipantUpdates {
  static String p1 = QrScannerState.result;
  static Participant participant = Participant.fromString(p1);

  void ticketConfirmApi(Participant participant) async {
    // API endpoint'i (istek kabul olacaksa confirm olan url)
    var apiUrl =
        'https://qr-pass-service-9363756ce9d4.herokuapp.com/v1/tickets/confirm';

    // API'ye göndermek istediğiniz veri (örnek olarak JSON formatında)
    var postData = {'eventId': participant.eventId, 'email': participant.email};
    var jsonData = jsonEncode(postData);

    // API'ye göndermek için kullanılacak token
    var accessToken = await ApiService.getToken();

    try {
      // HTTP isteği oluştur
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonData,
      );

      // Başarılı bir yanıt alındıysa
      if (response.statusCode == 200) {
        print('Başarılı: ${response.body}');
      } else {
        print('Hata: ${response.statusCode}');
        print('Hata Mesajı: ${response.body}');
      }
    } catch (error) {
      print('İstek yaparken bir hata oluştu: $error');
    }
  }

  void ticketDisableApi(Participant participant) async {
    // API endpoint'i (istek kabul olacaksa disable olan url)
    var apiUrl =
        'https://qr-pass-service-9363756ce9d4.herokuapp.com/v1/tickets/disable';

    // API'ye göndermek istediğiniz veri (örnek olarak JSON formatında)
    var postData = {'eventId': participant.eventId, 'email': participant.email};
    var jsonData = jsonEncode(postData);

    // API'ye göndermek için kullanılacak token
    var accessToken = await ApiService.getToken();

    try {
      // HTTP isteği oluştur
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonData,
      );

      // Başarılı bir yanıt alındıysa
      if (response.statusCode == 200) {
        print('Başarılı: ${response.body}');
      } else {
        print('Hata: ${response.statusCode}');
        print('Hata Mesajı: ${response.body}');
      }
    } catch (error) {
      print('İstek yaparken bir hata oluştu: $error');
    }
  }
}
