// lib/login.dart
import 'dart:convert';

import 'package:aa3_consumo_api/auth/forgot_password.dart';
import 'package:aa3_consumo_api/auth/register.dart';
import 'package:aa3_consumo_api/home.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'UnisexStyle',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'DancingScript',
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Fashion for all',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'DancingScript',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _emailError ? Colors.red : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _emailError ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      setState(() {
                        _emailError = true;
                      });
                      return 'Ingrese un correo electrónico válido';
                    }
                    setState(() {
                      _emailError = false;
                    });
                    return null;
                  },
                  onChanged: (value) {
                    if (value.contains('@')) {
                      setState(() {
                        _emailError = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _passwordError ? Colors.red : Colors.green,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: _passwordError ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 8) {
                      setState(() {
                        _passwordError = true;
                      });
                      return 'La contraseña debe tener al menos 8 caracteres';
                    }
                    setState(() {
                      _passwordError = false;
                    });
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length >= 8) {
                      setState(() {
                        _passwordError = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );
                      },
                      child: const Text(
                        'Olvidaste tu contraseña?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });

                        final apiUrl = dotenv.env['API_URL'];
                        final response = await http.post(
                          Uri.parse('$apiUrl/auth/login/'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          }),
                        );

                        if (response.statusCode == 200 || response.statusCode == 201) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          final jsonData = jsonDecode(response.body);
                          final errorMessage = utf8.decode(jsonData['non_field_errors'][0].codeUnits);
                          setState(() {
                            _loading = false;
                          });
                          Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Error",
                            desc: errorMessage,
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                                color: Colors.red,
                                child: const Text(
                                  "Cerrar",
                                  style: TextStyle(color: Colors.white, fontSize: 20,),
                                ),
                              )
                            ],
                          ).show();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                        : const Text(
                            'Iniciar sesión',
                            style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                          ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14), 
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Roboto'), 
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(' o iniciar sesión con '),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 32, 32, 32),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset('public/assets/img/icons/meta.png'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 32, 32, 32),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset('public/assets/img/icons/google.png'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 32, 32, 32),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset('public/assets/img/icons/apple.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}