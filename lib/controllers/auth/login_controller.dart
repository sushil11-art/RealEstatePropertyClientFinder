import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/config/shared_preferences.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/tabs/tabs_screen.dart';
import 'package:property_client_finder_app/services/auth/auth_services.dart';
import 'package:property_client_finder_app/services/auth/login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final box = GetStorage();

  var isPasswordInvisible = true.obs;

  var email = "";
  var password = "";
  var isAuthenticated = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void togglePassword() {
    isPasswordInvisible.value = !isPasswordInvisible.value;
  }

  String? validateEmail(String? value) {
    if (!EmailValidator.validate(value!)) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "Password must be at least 8 character long";
    }
    return null;
  }

  void loginBroker(BuildContext context) async {
    try {
      var valid = loginFormKey.currentState!.validate();
      FocusScope.of(context).requestFocus(FocusNode());
      if (!valid) {
        return;
      }
      loginFormKey.currentState!.save();

      isLoading.value = true;

      var response = await LoginServices.loginBroker(email, password);
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        isLoading.value = false;
        // progress.dismiss();
        // progress?.dismiss();

        var results = json.decode(response.body);
        // print(results["token"]);

        // await StorageManager().setUserToken(results["token"]);
        await StorageManager().setUserToken(results["token"]);
        // await box.write('token', results["token"]);
        final authService = Get.put(AuthService());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // final authService = Get.find<AuthService>();
        authService.setIsAuthenticated(prefs.getString('userToken'));
        if (authService.isAuthenticated.value) {
          clearController();
          Get.offAndToNamed(Routes.tabScreen);
        } else {
          clearController();
          Get.snackbar('Something went wrong', "Please try again",
              duration: const Duration(seconds: 5),
              backgroundColor: Colors.red,
              margin: const EdgeInsets.only(bottom: 40),
              snackPosition: SnackPosition.BOTTOM,
              snackStyle: SnackStyle.FLOATING);
        }
        // if (!(box.read('token').isEmpty)) {

        //   isAuthenticated.value = true;
        //   Get.offAndToNamed(Routes.tabScreen);
        // }
      }
      if ((response.statusCode == 400) ||
          (response.statusCode == 500) ||
          (response.statusCode == 422)) {
        isLoading.value = false;
        // progress?.dismiss();

        await Get.dialog(AlertDialog(
          title: const Text('Login failed'),
          content: const Text('Invalid email or password,please try again'),
          actions: [
            TextButton(
                onPressed: () => Get.back(), // Close the dialog
                child: const Text('Close'))
          ],
        ));
      }
    } catch (e) {
      isLoading.value = false;
      InvalidToken().showErrorSnackBar();
    }
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
