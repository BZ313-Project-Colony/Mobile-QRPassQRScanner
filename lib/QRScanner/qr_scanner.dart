import 'package:flutter/material.dart';
import 'package:login_screen/QRScanner/participants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'participant_uptades.dart';
//import 'package:url_launcher/url_launcher.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => QrScannerState();
}

class QrScannerState extends State<QrScanner> {
  // qr_code_scanner paketinden gelen controller'ı saklamak için bir anahtar
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  static String result = "";
  QRViewController? controller;
  ParticipantUptades participantUptades = ParticipantUptades();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // QRView nesnesi oluşturulduğunda bu metot çağrılır
  void onQRViewCreated(QRViewController controller) {
    // Controller'ı sakla
    this.controller = controller;

    // Tarayıcı tarafından bulunan her yeni QR kodu için çağrılan dinleyici
    controller.scannedDataStream.listen((scanData) {
      // State'i güncelle
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Qr Scanner",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // QR tarayıcı bölümü
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
            ),
          ),
          // Sonuç gösterim bölümü
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1.0),
              color: Colors.white,
              child: Center(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          // İşlem butonları bölümü
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(1.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Onayla butonu
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      if (result.isNotEmpty) {
                        //Clipboard.setData(ClipboardData(text: result));
                        // Kullanıcıya geri bildirim göster
                        //İstek basarılı olup kaydetmek istersek apı isteği çalışır
                        String p1 = QrScannerState.result;
                        Participant participant = Participant.fromString(p1);
                        participantUptades.ticketConfirmApi(participant);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Onaylandı"),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Onayla",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Reddet butonu
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      if (result.isNotEmpty) {
                        /*final Uri url = Uri.parse(result);
                        // URL'yi aç
                        await launchUrl(url);*/
                        //İstek basarılı olup daveti kabul etmezsek burdaki apı isteği çalışır
                        String p1 = QrScannerState.result;
                        Participant participant = Participant.fromString(p1);
                        participantUptades.ticketdisablemApi(participant);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Reddedildi"),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Reddet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
