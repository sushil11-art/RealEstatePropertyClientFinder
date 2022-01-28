import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final box = GetStorage();
// var token = box.read('token');

class HomeServices {
  static var client = http.Client();
  static Future addHome(data) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var body = json.encode(data);
      var url = API.localApiUrl + 'addHome';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
        body: body,
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      // return e;
    }
  }

  static Future editHome(data, propertyId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var body = json.encode(data);
      var url = API.localApiUrl + 'editHome/$propertyId';
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
        body: body,
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      // return e;
    }
  }
}
