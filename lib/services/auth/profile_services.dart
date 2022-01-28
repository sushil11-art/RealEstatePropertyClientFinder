import 'package:http/http.dart' as http;
// import 'package:property_client_finder_app/controllers/auth/change_password_controller.dart';
import 'dart:convert';

import 'package:property_client_finder_app/helpers/api_url.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final box = GetStorage();
// var token = box.read('token');

class ProfileServices {
  static var client = http.Client();
  static Future getProfileDetails() async {
    var token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('userToken');
    try {
      // Map data = {'oldPassword': oldPassword, 'newPassword': newPassword};
      // var body = json.encode(data);

      final url = API.localApiUrl + 'profile-details';
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
      // return e;
    }
  }
}
