// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_screen/QRScanner/qr_scanner.dart';


class QrHomePage extends StatelessWidget {
  const QrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Text("Qr için Tıklayınız"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrScanner(),
                    ));
              },
              child: Text("Burası"))
        ]),
      ),
    );
  }
}
