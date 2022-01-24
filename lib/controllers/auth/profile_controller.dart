import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'dart:convert';

// import 'package:property_client_finder_app/services/auth/chane_password_service.dart';
import 'package:property_client_finder_app/services/auth/profile_services.dart';

class GetProfile extends GetxController {
  var profile = {}.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    profileDetails();
    super.onInit();
  }

  void profileDetails() async {
    isLoading.value = true;
    var response = await ProfileServices.getProfileDetails();
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
      return;
    }
    if (response.statusCode == 200) {
      isLoading.value = false;
      var details = json.decode(response.body);
      profile.value = details;
      // print(profile);
    }
    if ((response.statusCode == 400) || (response.statusCode == 500)) {
      isLoading.value = false;
      Get.snackbar('Error occured', 'Failed to fetch profile details',
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
