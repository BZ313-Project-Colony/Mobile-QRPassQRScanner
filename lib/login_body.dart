// login_body.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'Services/ApiService.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  var logger = Logger(
    filter: DevelopmentFilter(),
  );

  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

  Future<void> _login() async {
    final String username = usernameController.text;
    final int password = int.parse(passwordController.text);

    try {
      await ApiService.login(username, password);
      // Successful login, handle the response as needed
      logger.i('Login Successful');
      // Navigate to the next screen or perform other actions
    } catch (error) {
      // Handle Login failure
      logger.e('Login Failed: $error');

      // Show error dialog on the screen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Giriş Başarısız'),
            content: const Text('Hatalı Kullanıcı Adı veya Şifre!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    var logger = Logger(
      filter: DevelopmentFilter(),
    );
    void togglePasswordVisibility() {
      setState(() {
        obscurePassword = !obscurePassword;
      });
      passwordController.value = passwordController.value.copyWith(
        text: passwordController.text,
        selection: TextSelection.collapsed(offset: passwordController.text.length),
        composing: TextRange.empty,
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight / 20),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("images/QRremoved.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(screenWidth / 70)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: "Şifre",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(screenWidth / 70)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisibility,
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight / 30),
              child: SizedBox(
                width: screenWidth / 1.2,
                height: screenHeight / 12,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _login();
                    logger.i('Giriş Yapıldı');
                  },
                  child: Text(
                    "GİRİŞ YAP",
                    style: TextStyle(
                      fontSize: screenWidth / 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
