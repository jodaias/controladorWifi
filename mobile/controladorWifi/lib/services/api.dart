import 'dart:async';
import 'package:controladorWifi/models/usermodel.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.2.71.22:3333";
//const baseUrl = "http://192.168.1.116:3333";
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

  static Future deleteUser(int id) {
    var url = baseUrl + "/users/$id";
    return http.delete(url);
  }

  static Future editUser(UserModel userModel) {
    var url = baseUrl + "/users/${userModel.id}";
    return http.put(url, body: userModel.toJson());
  }
}
