import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'widgets/welcome.dart';
import '/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentacion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = Uri.parse("http://192.168.100.18/apiCourier/v1/validateUser.php");
    var msg = "";
    var response = await http.post(url, body: {
      "usuario": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (!data["error"]) {
      msg = "Bienvenido: " + data["message"][0]["usuario"];
      _showAlertDialog();
      isLoading = false;
      print(
          msg); //Aqui va el toast en lugar del print, usando la misma variable msg

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoard(),
        ),
      );
    } else {
      msg = "Falló el inicio de sesión: " + data["message"];
      isLoading = false;
      print(
          msg); //Aqui va el toast en lugar del print, usando la misma variable msg
    }
  }

  bool isLoading = false;

  Future<void> guardar(user2, pass2) async {
    SharedPreferences perfs = await SharedPreferences.getInstance();
    await perfs.setString('user', user2);
    await perfs.setString('pass', pass2);
    await perfs.setBool('sesion', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AppCourier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //  Welcome(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
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
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  onPressed: () {
                    guardar(user, pass);
                    login();
                  },
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
                    isLoading = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Visibility(visible: false, child: Text("cargando....")),
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
            title: Text("Bienvenido"),
            content: Text(user.text + "ten un buen dia"),
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
}
