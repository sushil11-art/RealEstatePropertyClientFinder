import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:property_client_finder_app/controllers/auth/login_controller.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/auth/login_screen.dart';

final box = GetStorage();
// var token = box.read('token');

class LogoutController {
  void logout() {
    box.remove('token');
    // final LoginController loginController = Get.put(LoginController());
    // loginController.clearController();
    Get.offNamedUntil(Routes.login, (route) => true);
    // Get.reset();
  }
}
