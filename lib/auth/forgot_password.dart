import 'dart:convert';

import 'package:aa3_consumo_api/auth/confirm_code.dart';
import 'package:aa3_consumo_api/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailError = false;
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
                const SizedBox(height: 70),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recuperar contraseña',
                    style: TextStyle(
                      fontSize: 27,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingrese su correo electrónico para recuperar su contraseña, le enviaremos un codigo para restablecerla.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: const TextStyle(fontSize: 16),
                    errorStyle: const TextStyle(color: Colors.red), 
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
                    if (value.contains('@') && value.length > 5) {
                      setState(() {
                        _emailError = false;
                      });
                    } else {
                      setState(() {
                        _emailError = true;
                      });
                    }
                  },
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
                          Uri.parse('$apiUrl/auth/forgot-password/'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'email': _emailController.text,
                          }),
                        );

                        if (response.statusCode == 200 || response.statusCode == 201) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ConfirmCode(email: _emailController.text)),
                          );
                        } else {
                          final jsonData = jsonDecode(response.body);
                          final errorMessage = utf8.decode(jsonData['message'].codeUnits);
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
                            'Enviar',
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
                      backgroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), 
                        side: const BorderSide(color: Colors.black), 
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14), 
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Roboto'), 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}