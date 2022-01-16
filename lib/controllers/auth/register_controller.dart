import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
import 'package:property_client_finder_app/services/auth/register_services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final box = GetStorage();
  var isLoading = false.obs;

  var isPasswordInvisible = true.obs;

  var email = "";
  var password = "";
  var username = "";
  // final isAuthenticated = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    // usernameController.dispose();
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

  String? validateUsername(String? value) {
    if (value!.length < 6) {
      return "Username must be at least 6 character long";
    }
    return null;
  }

  void registerBroker(BuildContext context) async {
    var valid = registerFormKey.currentState!.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!valid) {
      return;
    }
    registerFormKey.currentState!.save();
    isLoading.value = true;
    // EasyLoading.show(status: 'Loading');

    var response =
        await RegitserServices.registerBroker(email, password, username);
    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar('Register Success', "Account created successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 60),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      Get.off(LoginScreen());
      // }
    }
    if (response.statusCode == 400) {
      isLoading.value = false;
      await Get.dialog(AlertDialog(
        title: const Text('Registration failed'),
        content: const Text('User with that email already exists'),
        actions: [
          TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Close'))
        ],
      ));
    }
    if ((response.statusCode == 500) || (response.statusCode == 422)) {
      isLoading.value = false;
      await Get.dialog(AlertDialog(
        title: const Text('Registration failed'),
        content: const Text('An error occured,please try again later'),
        actions: [
          TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Close'))
        ],
      ));
    }
    EasyLoading.dismiss();
  }
}
