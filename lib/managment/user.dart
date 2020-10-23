import 'package:http/http.dart' as http;
import 'package:igroove_ui/models/user.dart';
import 'dart:convert';

import '../const.dart';

class UserMeneger {
  List<UserModel> userList = List();

  bool dataLoaded = false;

  Future<String> getUser() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.encodeFull("$rootUrl/photos/"),
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        if (data != null && data.isNotEmpty) {
          data.forEach((element) {
            userList.add(
              UserModel.fromJson(element),
            );
          });
          print(userList);
        }

        return "succeed";
      } else if (response.statusCode == 404) {
        print('error -- ${response.statusCode}');
        return "Not Found";
      } else if (response.statusCode == 401) {
        print('error -- ${response.statusCode}');
        return "Unothorized";
      }
    } on http.ClientException catch (e) {
      return "failed";
    } catch (e) {
      return "failed";
    }
  }
}
