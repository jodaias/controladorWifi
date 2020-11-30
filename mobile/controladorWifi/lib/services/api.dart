import 'dart:async';
import 'package:controladorWifi/models/usermodel.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.2.71.9:3333";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
  }

  static Future postUser(UserModel userModel) {
    print(userModel.toJson());
    var url = baseUrl + "/users";
    return http.post(url, body: userModel.toJson());
  }
}
