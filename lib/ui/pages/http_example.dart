import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  List data;

  Future<String> getData() async {
    http.Response response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts/"),
      headers: {"Accept": "Application/json"},
    );

    setState(() {
      data = json.decode(response.body);
    });

    return "success";
  }

  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Json API")),
        backgroundColor: Colors.green,
        actions: [
          SizedBox(
            width: 50,
            height: 50,
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${data[index]["id"]}. '),
              Expanded(child: Text(data[index]["body"])),
            ],
          ),
        );
      },
    );
  }
}
