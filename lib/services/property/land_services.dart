import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';

final box = GetStorage();
var token = box.read('token');

class LandServices {
  static var client = http.Client();
  static Future addLand(data) async {
    try {
      var body = json.encode(data);
      var url = API.localApiUrl + 'addLand';
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

  static Future editLand(data, propertyId) async {
    try {
      var body = json.encode(data);
      var url = API.localApiUrl + 'editLand/$propertyId';
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
