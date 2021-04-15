import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Posts extends StatelessWidget {
  Future<List> getAllPosts() async {
    final response = await http.post(
        "http://192.168.1.95/proyectorecetas/Publicaciones.php",
        body: {});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Publicaciones"),
      ),
      body: new FutureBuilder<List>(
        future: getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(5.0),
          child: new GestureDetector(
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['Receta'],
                  style: TextStyle(fontSize: 23.0, color: Colors.black),
                ),
                leading: new Icon(
                  Icons.local_pizza,
                  size: 60.0,
                  color: Colors.blue[800],
                ),
                subtitle: new Text(
                  list[i]['Preparacion'],
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
