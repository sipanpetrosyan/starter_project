import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/managment/user.dart';
import 'package:igroove_ui/models/test_api.dart';

import '../../const.dart';

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  bool isLoading = true;
  bool errorApi = false;
  String errorText;

  AppManager _appManager = AppManager();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _appManager.userMeneger.getUserAPI().then((value) {
      if (value != null) {
        errorApi = true;
        errorText = value;
      }
      setState(() {
        isLoading = false;
      });
    });
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
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : (!errorApi)
            ? ListView.builder(
                itemCount: _appManager.userMeneger.testList == null
                    ? 0
                    : _appManager.userMeneger.testList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${_appManager.userMeneger.testList[index].id} '),
                            Expanded(
                                child: Text(
                                    '${_appManager.userMeneger.testList[index].title}')),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: Text(errorText));
  }
}
