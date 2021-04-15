import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyAppx extends StatefulWidget {
  MyAppx({this.usuarioID});
  final String usuarioID;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppx> {
  String _mySelection;
//sin prisas, es que nmms si ya tardo mas de lo normal, alo mucho un minuto
  final String url = "http://192.168.1.95/proyectorecetas/TraerCategoria.php";

  List data = List();

  Future<String> getCategoria() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Nueva Receta"),
        backgroundColor: Colors.black,
      ),
      body: new Center(
        child: new DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['Categoria']),
              value: item['IDCategoria'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
      ),
    );
  }
}
