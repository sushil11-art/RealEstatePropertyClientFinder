import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'dart:convert';

import 'package:property_client_finder_app/services/auth/chane_password_service.dart';

class ChangePassword extends GetxController {
  final passwordFormKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  var oldPassword;
  var newPassword;
  var isLoading = false.obs;

  var isOldInvisible = true.obs;

  var isNewInvisible = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // oldPasswordController.dispose();
    // newPasswordController.dispose();
    super.onClose();
  }

  void toggleOldPassword() {
    isOldInvisible.value = !isOldInvisible.value;
  }

  void toggleNewPassword() {
    isNewInvisible.value = !isNewInvisible.value;
  }

  String? validateCurrentPassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter current password";
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value!.length < 8) {
      return "New password must be at least 8 character long";
    }
    return null;
  }

  void chanePassword(BuildContext context) async {
    var valid = passwordFormKey.currentState!.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!valid) {
      return;
    }
    passwordFormKey.currentState!.save();

    isLoading.value = true;
    var response =
        await PasswordServices.changePassword(oldPassword, newPassword);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      isLoading.value = false;

      var results = json.decode(response.body);
      Get.snackbar('Password updated', "Password updated successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 70),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
      oldPasswordController.clear();
      newPasswordController.clear();
      // print(results["token"]);

    }
    if ((response.statusCode == 400) || (response.statusCode == 500)) {
      isLoading.value = false;
      Get.snackbar(
          'Error occured', "Enter correct old password and try again later",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 70),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
      // progress?.dismiss();

    }
  }
}
