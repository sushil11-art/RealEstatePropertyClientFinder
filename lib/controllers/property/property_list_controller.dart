import 'package:get/state_manager.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:property_client_finder_app/models/property.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:http/http.dart' as http;
// import 'package:property_client_finder_app/models/property.dart';
import 'package:property_client_finder_app/services/property/property_list_services.dart';

class PropertyListController extends GetxController {
  // List propertyList = [].obs;
  var propertyList = [].obs;

  var propertyDescription = {}.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchProperties();

    super.onInit();
  }

  void fetchProperties() async {
    EasyLoading.show(status: 'Loading');

    try {
      var propertiesList = await PropertyListServices.getProperties();
      propertyList.value = propertiesList.properties;
      // print(propertiesList.properties[0].id);
      // update();
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }

  void deleteProperty(propertyId, landId, homeId) async {
    EasyLoading.show(status: 'Loading');
    var response =
        await PropertyListServices.deleteProperty(propertyId, landId, homeId);

    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      EasyLoading.dismiss();
      Get.snackbar('Property deleted', "Property deleted successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      // Get.off(LoginScreen());
      Get.offAndToNamed(Routes.home);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      EasyLoading.dismiss();
      Get.snackbar('Error occured', "Failed to delete property details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
    }
    fetchProperties();
    // update();
  }

  void propertyDetails(propertyId) async {
    EasyLoading.show(status: 'Loading');
    try {
      var response = await PropertyListServices.propertyDetails(propertyId);
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        propertyDescription.value = decodedResponse;
        Get.offAndToNamed(Routes.propertyDetails);
        EasyLoading.dismiss();
      }
      // print(propertyDescription);
      if ((response.statusCode == 400) || (response.statusCode == 500)) {
        EasyLoading.dismiss();
        Get.snackbar('Error occured', "Failed to fetch property details",
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error occured', "Something went wrong",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
    }
  }
}