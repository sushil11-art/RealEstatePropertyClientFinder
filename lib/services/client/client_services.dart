import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:property_client_finder_app/models/property_list.dart';

// final box = GetStorage();
// var token = box.read('token');

class ClientServices {
  static Future getClients() async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var url = API.localApiUrl + "allClient";
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );

      return response;
      // return decoded;
    } catch (e) {
      print(e);
    }
  }

  static Future deleteClient(clientId) async {
    var baseUrl = API.localApiUrl;
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var url = baseUrl + "deleteClient/$clientId";
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

  static Future clientDetails(clientId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      final url = API.localApiUrl + "getClient/$clientId";

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

  static Future addClient(data) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      final url = API.localApiUrl + "addClient";
      var body = json.encode(data);
      final response = await http.post(
          Uri.parse(
            url,
          ),
          headers: <String, String>{
            'Content-Type': 'Application/json; charset=UTF-8',
            'authorization': token
          },
          body: body);

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future editClient(data, clientId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      final url = API.localApiUrl + "editClient/$clientId";
      var body = json.encode(data);
      final response = await http.put(
          Uri.parse(
            url,
          ),
          headers: <String, String>{
            'Content-Type': 'Application/json; charset=UTF-8',
            'authorization': token
          },
          body: body);

      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future getMatchingPropertiesForClient(clientId) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      var url = API.localApiUrl + "allProperty/$clientId";
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
