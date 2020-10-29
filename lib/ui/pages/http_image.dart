import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/app_manager.dart';

class HttpImagePage extends StatefulWidget {
  @override
  _HttpImagePageState createState() => _HttpImagePageState();
}

class _HttpImagePageState extends State<HttpImagePage> {
  bool isLoading = true;
  bool isFailed = true;
  bool isNotFound = true;
  bool isUnothorized = true;
  bool errorApi = false;
  String errorText;
  AppManager _appManager = AppManager();

  @override
  void initState() {
    super.initState();
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
        title: Center(child: Text("Json image API")),
        backgroundColor: Colors.teal[300],
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
            ? GridView.count(
                crossAxisCount: 10,
                children: List.generate(
                    _appManager.userMeneger.testList == null
                        ? 0
                        : _appManager.userMeneger.testList.length, (index) {
                  return Center(
                    child: Image.network(
                        _appManager.userMeneger.testList[index].thumbnailUrl),
                  );
                }),
              )
            : Center(child: Text(errorText));
  }
}
