import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';
import 'package:property_client_finder_app/controllers/upload/upload_file_controller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:property_client_finder_app/helpers/create_image_url.dart';
import 'package:property_client_finder_app/routes.dart';

// import 'package:property_client_finder_app/services/auth/chane_password_service.dart';
import 'package:property_client_finder_app/services/auth/profile_services.dart';
import 'package:property_client_finder_app/services/upload/image_upload_services.dart';

class EditProfileController extends GetxController {
  final editProfileFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  // var profile = {}.obs;
  var isLoading = false.obs;
  var isProfileImageError = false.obs;
  var isProfileEditMode = false.obs;

  ImageUploadController imageUploadController =
      Get.put(ImageUploadController());

  var username;
  var profileImage;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // profileDetails();
    super.onInit();
  }

  String? validateUsername(String? value) {
    if (value!.length < 6) {
      return "Username must be at least 6 character long";
    }
    return null;
  }

  void editProfileDetails(File? image, BuildContext context) async {
    try {
      var valid = editProfileFormKey.currentState!.validate();
      FocusScope.of(context).requestFocus(FocusNode());
      if (!valid) {
        return;
      }
      editProfileFormKey.currentState!.save();
      isLoading.value = true;
      List<String> images = [];
      if (image != null) {
        // print("old image was used");
        var res = await ImageUploadServices.uploadProfileImage(image);
        var responseData = await http.Response.fromStream(res);
        var decodedData =
            json.decode(responseData.body) as Map<String, dynamic>;
        // print(decodedData["data"]["images"]);
        if (responseData.statusCode == 401) {
          isLoading.value = false;
          InvalidToken().showSnackBar();
          LogoutController().logout();
          return;
        }
        if (responseData.statusCode == 200) {
          for (var image in decodedData["data"]["images"]) {
            images.add(image);
          }
          // return;
        }
        if ((responseData.statusCode == 400) ||
            (responseData.statusCode == 500)) {
          // EasyLoading.dismiss();
          isLoading.value = false;
          Get.snackbar('Error occured', "Uploading images failed",
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red,
              margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
              snackPosition: SnackPosition.TOP,
              snackStyle: SnackStyle.FLOATING);
          return;
        }
      }

      Map data = {
        'username': username,
        'imageUrl': images.isNotEmpty ? images[0] : null
      };

      var response = await ProfileServices.editProfileServices(data);
      if (response.statusCode == 401) {
        isLoading.value = false;
        InvalidToken().showSnackBar();
        LogoutController().logout();
      }
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // EasyLoading.dismiss();
        isLoading.value = false;

        Get.snackbar('Profile updated', "Details uploaded successfully",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        // Get.off(LoginScreen());
        clearController();
        // Get.delete<GetProfile>();
        final GetProfile profile = Get.put(GetProfile());
        profile.profileDetails();
        profile.refresh();
        // Navigator.pop(context);
        // profileDetails();
        // Get.reset();
        // Get.delete<GetProfile>();
        Get.offAndToNamed(Routes.tabScreen);
        // Navigator.pop(context);

        // Get.offAndToNamed(Routes.tabScreen);
      }
      if ((response.statusCode == 500) || (response.statusCode == 422)) {
        // EasyLoading.dismiss();
        isLoading.value = false;
        Get.snackbar('Error occured', "Failed to upload details",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            margin:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING);
        // await Get.dialog(AlertDialog(
        //   title: const Text('Registration failed'),
        //   content: const Text('An error occured,please try again later'),
        //   actions: [
        //     TextButton(
        //         onPressed: () => Get.back(), // Close the dialog
        //         child: const Text('Close'))
        //   ],
        // ));
      }
    } catch (e) {
      isLoading.value = false;
      InvalidToken().showErrorSnackBar();
    }
  }

  void getProfileDetails() async {
    final GetProfile profileController = Get.put(GetProfile());

    try {
      profileController.isLoading.value = true;
      var response = await ProfileServices.getProfileDetails();
      if (response.statusCode == 401) {
        isLoading.value = false;
        // InvalidToken().showSnackBar();
        // LogoutController().logout();
        // return;
      }
      if (response.statusCode == 200) {
        profileController.isLoading.value = false;
        var details = json.decode(response.body);
        // profile.value = details;
        usernameController.text = details["data"]["broker"]["username"];
        if (details["data"]["broker"]["imageUrl"] != null) {
          final createImageUrl = CreateImageUrl();
          profileImage = createImageUrl
              .profileImage(details["data"]["broker"]["imageUrl"]);
          isProfileEditMode.value = true;
        }
        Get.toNamed(Routes.editProfile);
        // print(profile);
      }
      if ((response.statusCode == 400) || (response.statusCode == 500)) {
        profileController.isLoading.value = false;
        Get.snackbar('Error occured', 'Failed to fetch profile details',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            margin:
                const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 70),
            snackPosition: SnackPosition.BOTTOM,
            snackStyle: SnackStyle.FLOATING);
        // progress?.dismiss();

      }
    } catch (e) {
      profileController.isLoading.value = false;
      print(e);
      // InvalidToken().showErrorSnackBar();
    }
  }

  void clearController() {
    usernameController.clear();
  }
}
