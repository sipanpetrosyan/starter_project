import 'package:flutter/material.dart';
import 'package:igroove_ui/models/user_model.dart';

import 'package:http/http.dart' as http;

class PostRequestPage extends StatefulWidget {
  @override
  _PostRequestPageState createState() => _PostRequestPageState();
}

Future<UserModel> createUser(String name, String jobTitle) async {
  final String apiUrl = "https://reqres.in/api/users";
  final response = await http.post(apiUrl, body: {
    "name": name,
    "job": jobTitle,
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _PostRequestPageState extends State<PostRequestPage> {
  UserModel _user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Request'),
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: jobController,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: OutlineButton(
                onPressed: () async {
                  final String name = nameController.text;
                  final String jobTitle = jobController.text;
                  final UserModel user = await createUser(name, jobTitle);
                  setState(() {
                    _user = user;
                  });
                  print('Post');
                },
                child: Text('Post Request'),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _user != null ? Text('id: ${_user.id}, name: ${_user.name}, time: ${_user.createdAt.toIso8601String()}'):Container()
        ],
      ),
    );
  }
}
