import 'package:flutter/material.dart';
import 'package:igroove_ui/managment/user.dart';

class HttpImagePage extends StatefulWidget {
  @override
  _HttpImagePageState createState() => _HttpImagePageState();
}

class _HttpImagePageState extends State<HttpImagePage> {
  bool isLoading = true;
  bool isFailed = true;
  bool isNotFound = true;
  bool isUnothorized = true;
  UserMeneger _userMeneger = UserMeneger();

  @override
  void initState() {
    super.initState();
    _userMeneger.getUser().then((value) {
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
        : (isFailed && isNotFound && isUnothorized)
            ? GridView.count(
                crossAxisCount: 10,
                children: List.generate(
                    _userMeneger.userList == null
                        ? 0
                        : _userMeneger.userList.length, (index) {
                  return Center(
                    child: Image.network(
                        _userMeneger.userList[index].thumbnailUrl),
                  );
                }),
              )
            : Center(
                child: Text(!isFailed
                    ? 'Failed !!!'
                    : !isNotFound
                        ? 'Not Found !!!'
                        : !isUnothorized ? 'Unothorized !!!' : null));
  }
}
