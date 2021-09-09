import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '/DashBoard.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController correo = TextEditingController();
  Future register() async {
    var url = Uri.parse("http://192.168.100.18/apiCourier/v1/registerUser.php");
    var msg = "";
    var response = await http.post(url, body: {
      "cedula": cedula.text,
      "nombres": user.text,
      "password": pass.text,
      "correo": correo.text,
    });
    var data = json.decode(response.body);
    if (!data["error"]) {
      msg = data["message"];
      print(msg);
      //Aqui va el toast en lugar del print, usando la misma variable msg
      _showAlertDialog();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } else {
      msg = "Falló el inicio de sesión: " + data["message"];
      print(
          msg); //Aqui va el toast en lugar del print, usando la misma variable msg
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login SignUp',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: user,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: correo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Cedula',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                    LengthLimitingTextInputFormatter(10)
                  ],
                  controller: cedula,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: pass,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.green[200],
                  minWidth: 500.0,
                  height: 50.0,
                  child: Text('Register',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    register();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.green[200],
                  minWidth: 500.0,
                  height: 50.0,
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Registro"),
            content: Text("Registro exitoso" + user.text),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  final RegExp phoneRegex = RegExp(r'\d$');
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
}
