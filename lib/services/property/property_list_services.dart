import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/helpers/api_url.dart';
import 'dart:convert';

import 'package:property_client_finder_app/models/property_list.dart';

final box = GetStorage();
var token = box.read('token');

class PropertyListServices {
  static Future getProperties() async {
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
      List decoded = json.decode(response.body);
      // print(decojded);
      PropertyList propertyList = PropertyList.fromJson(decoded);
      // print(propertyList.properties);
      return propertyList;
    } catch (e) {
      print(e);
      // rethrow;
      // return e;
    }
  }

  static Future deleteProperty(propertyId, landId, homeId) async {
    // print(propertyId);
    // print(landId);
    // print(homeId);
    // Map<String, dynamic> queryParams = {'propertyId': propertyId};
    var base_url = API.localApiUrl;
    try {
      var url;
      if (homeId == null) {
        // url = 'http://10.0.2.2:3005/api/v1/deleteLand/${propertyId}';
        url = base_url + "deleteLand/$propertyId";
      } else {
        // url = 'http://10.0.2.2:3005/api/v1/deleteHome/${propertyId}';
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
      // print(resposnse);
      // return response;
      // var decoded = json.decode(response.body);
      return response;
    } catch (e) {
      print(e);
      // return e;
      // print(e);
    }
  }

  static Future propertyDetails(propertyId) async {
    try {
      // final url = 'http://10.0.2.2:3005/api/v1/getProperty/$propertyId';
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
      // var propertyDetails = json.decode(response.body);
      // return propertyDetails;
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future getMatchingClientsForProperty(propertyId) async {
    try {
      var url = API.localApiUrl + "allClient/$propertyId";
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
        },
      );
      // List decoded = json.decode(response.body);
      return response;
    } catch (e) {
      print(e);
    }
  }
}
