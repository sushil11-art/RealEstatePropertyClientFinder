import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;

  RxBool isAuthenticated = false.obs;

  void setIsAuthenticated(String? token) {
    if (token != null) {
      isAuthenticated.value = true;
    }
  }
}
