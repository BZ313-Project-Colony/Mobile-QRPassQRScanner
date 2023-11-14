import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    var logger =Logger(
      filter: DevelopmentFilter(),
    );

    final String apiUrl = "";
    final String username = usernameController.text;
    final String password = passwordController.text;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      //Successful login, handle the response as needed
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('Login Successful: $data');
      logger.i('Login Successful: $data');
      //Navigate to the next screen or perform other actions
    } else {
      //Handle Login failure
      print('Login Failed: ${response.statusCode}');
      print('Login Failed: ${response.body}');
      logger.e('Login Failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
     var screenInfo= MediaQuery.of(context);
     final double screenHeight = screenInfo.size.height;
     final double screenWidth = screenInfo.size.width;
     var logger = Logger(
       filter: DevelopmentFilter(), // Change to DevelopmentFilter() for all logs
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

     return Scaffold(
       backgroundColor: Colors.black,
       body: Center(
         child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(bottom: screenHeight/20),
               child: SizedBox(
                 width: 200,
                 height: 200,
                 child: Image.asset("images/QRremoved.png",),
               ),
             ),
             Padding(
               padding: EdgeInsets.all(screenHeight/30),
               child: TextField(
                 controller: usernameController,
                 decoration: InputDecoration(
                   hintText: "Kullanıcı Adı",
                   filled: true, //Activated background color.
                   fillColor: Colors.white,
                   border: OutlineInputBorder(//Adding Frame
                     borderRadius: BorderRadius.all(Radius.circular(screenWidth/70)),
                   ),
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.all(screenHeight/30),
               child: TextField(
                 controller: passwordController,
                 obscureText: obscurePassword,//Hiding feature when entering password.
                 decoration: InputDecoration(
                   hintText: "Şifre",
                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(screenWidth/70)),
                   ),
                   suffixIcon:
                     IconButton(
                         onPressed: togglePasswordVisibility,
                         icon: Icon(
                           obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.black,
                         )),
                 ),
                ),
               ),


             Padding(
               padding: EdgeInsets.all(screenHeight/30),
               child: SizedBox(
                 width: screenWidth/1.2,
                 height: screenHeight/12,
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,),
                   onPressed: (){
                     _login();
                     logger.i('Giriş Yapıldı');
                   },
                   child: Text("GİRİŞ YAP",
                   style: TextStyle(
                     fontSize: screenWidth/25,
                     color: Colors.black,),
                   ),
                 ),
               ),
             ),
           ],
          ),
         ),
       ),
    );
  }
}
