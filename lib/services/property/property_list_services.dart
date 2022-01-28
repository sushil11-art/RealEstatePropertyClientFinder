import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';
import 'dart:convert';

import 'package:property_client_finder_app/models/property_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final box = GetStorage();
// var token = box.read('token');

class PropertyListServices {
  static Future getProperties() async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      // Map data = {'email': email, 'password': password};
      // var body = json.encode(data);
      var url = API.localApiUrl + "allProperty";
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );

      return response;
    } catch (e) {
      print(e);
      // rethrow;
      // return e;
    }
  }

  static Future deleteProperty(propertyId, landId, homeId) async {
    var base_url = API.localApiUrl;
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var url;
      if (homeId == null) {
        url = base_url + "deleteLand/$propertyId";
      } else {
        url = base_url + "deleteHome/$propertyId";
      }
      // print(url);
      final response = await http.delete(
        Uri.parse(
          url,
        ),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future propertyDetails(propertyId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      final url = API.localApiUrl + "getProperty/${propertyId}";

      final response = await http.get(
        Uri.parse(
          url,
        ),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future getMatchingClientsForProperty(propertyId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var url = API.localApiUrl + "allClient/$propertyId";
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );
      return response;
    } catch (e) {
      print(e);
    }
  }
}
