// lib/auth_methods.dart
import 'package:aa3_consumo_api/auth/login.dart';
import 'package:flutter/material.dart';

class AuthMethods extends StatefulWidget {
  @override
  _AuthMethodsState createState() => _AuthMethodsState();
}

class _AuthMethodsState extends State<AuthMethods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('public/assets/img/auth_methods.jpg'),
                fit: BoxFit.fill,
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
                    fontSize: 48,
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Fashion for all',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'DancingScript',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 20, fontFamily: 'Roboto'), 
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, 
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), 
                          side: const BorderSide(color: Colors.white), 
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10), 
                      ),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Roboto'), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}