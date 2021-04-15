import 'package:flutter/material.dart';
import 'package:receta_yucatan_app_mobile/main.dart';
import 'package:receta_yucatan_app_mobile/menu/MyRecets.dart';
import 'package:receta_yucatan_app_mobile/menu/Posts.dart';
import 'package:receta_yucatan_app_mobile/menu/NuevaReceta.dart';

class MyApp extends StatelessWidget {
  MyApp({this.usuarioID});
  final String usuarioID;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(
          'Receta Yucateca',
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Aplicacion Funcional',
        ),
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Recetas Yucatecas  Movil App',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          new ListTile(
            leading: Icon(Icons.home),
            title: Text('Mis Recetas'),
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MyRecets(usuarioID: usuarioID)),
            ),
          ),
          new ListTile(
            leading: Icon(
              Icons.assignment_outlined,
            ),
            title: Text('Publicaciones'),
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Posts()),
            ),
          ),
          new ListTile(
            leading: Icon(
              Icons.plus_one,
            ),
            title: Text('Nuevo'),
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MyAppx(usuarioID: usuarioID)),
            ),
          ),
          new ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar Sesion'),
            onTap: () => {
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context) => new InicioSesion()),
              )
            },
          ),
        ],
      ),
    );
  }
}
