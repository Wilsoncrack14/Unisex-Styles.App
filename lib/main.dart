import 'package:aa3_consumo_api/auth/confirm_code.dart';
import 'package:aa3_consumo_api/auth/forgot_password.dart';
import 'package:aa3_consumo_api/auth/login.dart';
import 'package:aa3_consumo_api/auth/register.dart';
import 'package:aa3_consumo_api/auth/reset_password.dart';
import 'package:aa3_consumo_api/auth_methods.dart';
import 'package:aa3_consumo_api/home.dart';
import 'package:aa3_consumo_api/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'UnisexStyle',
      theme: ThemeData(
        primarySwatch: Colors.purple, 
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}