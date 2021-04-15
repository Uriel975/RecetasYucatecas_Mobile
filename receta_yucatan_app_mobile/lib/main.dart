import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:receta_yucatan_app_mobile/menu/menuPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(InicioSesion());
String usuarioID;

class InicioSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/menuPage': (BuildContext context) => new MyApp(usuarioID: usuarioID),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerCorreo = new TextEditingController();
  TextEditingController controllerContrasena = new TextEditingController();

  Future<List> login() async {
    final response = await http
        .post("http://192.168.1.95/proyectorecetas/ValidarUsuario.php", body: {
      "correo": controllerCorreo.text,
      "contraseña": controllerContrasena.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
    } else {
      Navigator.pushReplacementNamed(context, '/menuPage');

      setState(() {
        usuarioID = datauser[0]['IDUsuario'];
      });

      return datauser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 125.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50, right: 80),
                      child: Text(
                        'Recetas Yucatecas',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    padding:
                        EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: TextField(
                      controller: controllerCorreo,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black,
                        ),
                        hintText: 'Correo',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: TextField(
                      obscureText: true,
                      controller: controllerContrasena,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.black,
                        ),
                        hintText: 'Contraseña',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  InkWell(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Iniciar  Sesion'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
