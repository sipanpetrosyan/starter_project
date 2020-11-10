import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igroove_ui/constant/const.dart';
import 'package:igroove_ui/models/basic_api_response.dart';
import 'package:igroove_ui/models/test_api.dart';

class UserAPI {
  Future<BasicResponse<List<TestApiModel>>> getUser() async {
    http.Response response;

    String error;

    List<TestApiModel> data;
    try {
      response = await http.get(
        Uri.encodeFull("$rootUrl/photos/"),
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 200) {
        data = (jsonDecode(response.body) as List).map((e) => TestApiModel.fromJson(e)).toList();

      
      } else if (response.statusCode == 404) {
        print('error -- ${response.statusCode}');
        error = "Not Found";
      } else if (response.statusCode == 401) {
        print('error -- ${response.statusCode}');
        error = "Unothorized";
      }
    } on http.ClientException catch (e) {
      error = "failed";
    } catch (e) {
      error = "failed";
    }

    return BasicResponse(
      response: data,
      error: error,
    );
  }
}
