import 'dart:convert';

import 'package:aa3_consumo_api/auth/login.dart';
import 'package:aa3_consumo_api/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmCode extends StatefulWidget {
  final String email;

  ConfirmCode({required this.email});
  
  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  final _formKey = GlobalKey<FormState>();
  final _codeControllers = List<TextEditingController>.generate(6, (_) => TextEditingController());
  final _codeError = List<bool>.generate(6, (_) => false);
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
                // Título "Confirmar código"
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirmar código',
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
                    'Ingrese el código de verificación que le enviamos a su correo electrónico.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCodeField(0),
                    _buildCodeField(1),
                    _buildCodeField(2),
                    _buildCodeField(3),
                    _buildCodeField(4),
                    _buildCodeField(5),
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
                          Uri.parse('$apiUrl/auth/verify-code/'),
                          headers: {
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'code': _codeControllers.fold<String>('', (prev, controller) => prev + controller.text),  
                            'email': widget.email,
                          }),
                        );

                        if (response.statusCode == 200 || response.statusCode == 201) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPassword(
                              code: _codeControllers.fold<String>('', (prev, controller) => prev + controller.text),
                              email: widget.email,
                            )),
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

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 40,
      child: TextFormField(
        controller: _codeControllers[index],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: _codeError[index] ? Colors.red : Colors.black,
            ),
          ),
          errorText: _codeError[index] ? 'Ingrese un número' : null,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese un dígito';
          }
          if (!RegExp(r'^\d+$').hasMatch(value)) {
            return 'Ingrese un número';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          setState(() {
            _codeError[index] = !RegExp(r'^\d+$').hasMatch(value);
          });
        },
      ),
    );
  }
}