import 'package:property_client_finder_app/services/auth/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class StorageManager {
  clearSharedPreference() async {
    // SharedPreferences spreferences =
    //     PreferenceManager.getDefaultSharedPreferences(getApplicationContext());
    // SharedPreferences.Editor editor = spreferences.edit();
    // editor.clear();
    // editor.commit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.)
    prefs.remove('userToken');
  }

  setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  tryAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('userToken');
    if (token != null) {
      var authService = Get.put(AuthService());
      authService.setIsAuthenticated(token);
      return true;
    } else {
      return false;
    }
  }
}
