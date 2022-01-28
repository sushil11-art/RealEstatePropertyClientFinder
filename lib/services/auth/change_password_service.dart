import 'package:http/http.dart' as http;
import 'package:property_client_finder_app/config/shared_preferences.dart';
// import 'package:property_client_finder_app/controllers/auth/change_password_controller.dart';
import 'dart:convert';

import 'package:property_client_finder_app/helpers/api_url.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final box = GetStorage();
// var token;
// var token = StorageManager().getToken();

class PasswordServices {
  static var client = http.Client();
  // var token;
  static Future changePassword(var oldPassword, var newPassword) async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      Map data = {'oldPassword': oldPassword, 'newPassword': newPassword};
      var body = json.encode(data);
      final url = API.localApiUrl + 'changePassword';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'Application/json; charset=UTF-8',
          'authorization': token
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
