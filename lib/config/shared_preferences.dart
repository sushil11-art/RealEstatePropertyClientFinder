// import 'package:shared_preferences/shared_preferences.dart';

// class StorageManager {
//   clearSharedPreference() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }

//   setUserToken(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('userToken', token);
//   }

//   Future<String?> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userToken');
//   }
// }
