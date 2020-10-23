import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:igroove_ui/managment/app_manager.dart';
import 'package:igroove_ui/managment/user.dart';
import 'package:igroove_ui/models/user.dart';

import '../../const.dart';

class HttpPage extends StatefulWidget {
  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> {
  bool isLoading = true;
  bool isFailed = true;
  bool isNotFound = true;
  bool isUnothorized = true;

  AppManager _appManager = AppManager();

  @override
  void initState() {
    super.initState();
    if (!_appManager.userMeneger.dataLoaded) {
      _appManager.userMeneger.getUser().then((value) {
        _appManager.userMeneger.dataLoaded = true;
        isLoading = false;
        if (value == 'failed') {
          print('failed');
          isFailed = false;
        }
        if (value == 'Not Found') {
          print('Not Found');
          isNotFound = false;
        }
        if (value == 'Unothorized') {
          print('Unothorized');
          isUnothorized = false;
        }
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      isLoading = false;
    }
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
        : (isFailed && isNotFound && isUnothorized)
            ? ListView.builder(
                itemCount: _appManager.userMeneger.userList == null
                    ? 0
                    : _appManager.userMeneger.userList.length,
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
                                '${_appManager.userMeneger.userList[index].id} '),
                            Expanded(
                                child: Text(
                                    '${_appManager.userMeneger.userList[index].title}')),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(!isFailed
                    ? 'Failed !!!'
                    : !isNotFound
                        ? 'Not Found !!!'
                        : !isUnothorized ? 'Unothorized !!!' : null));
  }
}
