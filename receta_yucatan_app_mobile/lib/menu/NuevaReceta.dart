import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//La verdad la verdad, no se, intenta cargar todo esto a tu movil, conectalo y lo ej
//aaaa ya se que paso pelani , acuerdate que ayer cambiaste la ip cuando lo desconecte ;v
//No, pero lo corregimos incluso agregamos un datos desde el movil...aaa chingaos , pos lo recargare

class MyAppx extends StatefulWidget {
  MyAppx({this.usuarioID});
  final String usuarioID;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppx> {
  //---Categoria---
  TextEditingController controllerReceta = new TextEditingController();
  TextEditingController controllerTiempo = new TextEditingController();
  TextEditingController controllerIngred = new TextEditingController();
  TextEditingController controllerPrepar = new TextEditingController();
  //UsuarioID
  //Categoria

  var _formKey = GlobalKey<FormState>();

  String _mySelection;

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

  void guardaReceta() {
    var url = "http://192.168.1.95/proyectorecetas/AgregarReceta.php";

    http.post(url, body: {
      "nombre": controllerReceta.text,
      "tiempo": controllerTiempo.text,
      "ingre": controllerIngred.text,
      "prepa": controllerPrepar.text,
      "usua": widget.usuarioID,
      "cate": _mySelection.toString(),
    });
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
        title: Text("Nueva Receta " + widget.usuarioID),
        backgroundColor: Colors.black,
      ),
      body: new Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  //Receta
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding:
                        EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: ListTile(
                      leading:
                          const Icon(Icons.local_pizza, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerReceta,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Ingresa El Nombre De La Receta";
                        },
                        decoration: new InputDecoration(
                          hintText: "Receta",
                          labelText: "Receta",
                        ),
                      ),
                    ),
                  ),
                  //Tiempo
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: ListTile(
                      leading: const Icon(Icons.timelapse, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerTiempo,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Ingresa El Tiempo De La Receta";
                        },
                        decoration: new InputDecoration(
                          hintText: "Tiempo",
                          labelText: "Tiempo",
                        ),
                      ),
                    ),
                  ),
                  //Ingredientes
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: ListTile(
                      leading: const Icon(Icons.format_list_numbered,
                          color: Colors.black),
                      title: new TextFormField(
                        controller: controllerIngred,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Ingresa Los Ingredientes De La Receta";
                        },
                        decoration: new InputDecoration(
                          hintText: "Ingredientes",
                          labelText: "Ingredientes",
                        ),
                      ),
                    ),
                  ),
                  //Preparacion
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: ListTile(
                      leading: const Icon(Icons.list, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerPrepar,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Ingresa La Preparacion De La Receta";
                        },
                        decoration: new InputDecoration(
                          hintText: "Preparacion",
                          labelText: "Preparacion",
                        ),
                      ),
                    ),
                  ),
                  //Categoria
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                    child: DropdownButton(
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
                  //Boton GUardar
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    child: RaisedButton(
                      child: new Text("Agregar",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.black,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          guardaReceta();
                          Navigator.pop(context);
                        }
                      },
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
