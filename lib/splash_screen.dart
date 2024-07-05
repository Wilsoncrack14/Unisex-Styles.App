import 'package:aa3_consumo_api/auth_methods.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('public/assets/img/splash_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'UnisexStyle',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Fashion for all',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Redireccionamos a auth_methods.dart después de 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthMethods()),
      );
    });
  }
}