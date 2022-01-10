import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:property_client_finder_app/helpers/api_url.dart';

class RegitserServices {
  static var client = http.Client();
  static Future registerBroker(var email, var password, var username) async {
    try {
      Map data = {'email': email, 'password': password, 'username': username};
      var body = json.encode(data);
      final url = API.localApiUrl + 'registerBroker';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (e) {
      print(e);
      // return e;
    }
  }
}
