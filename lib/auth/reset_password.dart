import 'dart:convert';

import 'package:aa3_consumo_api/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  final String code;

  ResetPassword({required this.email, required this.code});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo y slogan de UnisexStyle
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
                // Título "Restablecer contraseña"
                const SizedBox(height: 10),
                // Campo de texto para la nueva contraseña
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Nueva contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese una contraseña';
                    }
                    if (value.length < 8) {
                      return 'La contraseña debe tener al menos 8 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Campo de texto para confirmar la contraseña
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la contraseña nuevamente';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
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
                          Uri.parse('$apiUrl/auth/reset-password/'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'code': widget.code,
                            'email': widget.email,
                            'password': _passwordController.text,
                          }),
                        );

                        if (response.statusCode == 200 || response.statusCode == 201) {
                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "Exito!",
                            desc: "Contraseña restablecida correctamente. Ahora puede iniciar sesión.",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                                color: Colors.green,
                                child: const Text(
                                  "Cerrar",
                                  style: TextStyle(color: Colors.white, fontSize: 20,),
                                ),
                              )
                            ],
                          ).show();
                          setState(() {
                            _loading = false;
                          });
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
                            'Registrarse',
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