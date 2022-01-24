import 'package:get/state_manager.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/property/home_controller.dart';
import 'package:property_client_finder_app/controllers/property/land_controller.dart';
import 'package:property_client_finder_app/models/property_list.dart';
import 'package:property_client_finder_app/routes.dart';

import 'package:property_client_finder_app/services/property/property_list_services.dart';
import 'package:property_client_finder_app/models/property_list.dart';

class PropertyListController extends GetxController {
  // List propertyList = [].obs;
  var propertyList = [].obs;
  var matchingClientList = [].obs;

  var propertyDescription = {}.obs;
  var isLoading = false.obs;
  ClientController clientController = Get.put(ClientController());
  GetProfile profileController = Get.put(GetProfile());

  @override
  void onInit() {
    // TODO: implement onInit
    fetchProperties();
    // profileController.profileDetails();
    // clientController.fetchClients();

    super.onInit();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   clientController.clientList();
  //   super.onClose();
  // }

  void fetchProperties() async {
    // EasyLoading.show(status: 'Loading');
    isLoading.value = true;
    try {
      var response = await PropertyListServices.getProperties();
      // print(response.statusCode);
      if (response.statusCode == 401) {
        isLoading.value = false;
        InvalidToken().showSnackBar();
        LogoutController().logout();
      }
      if (response.statusCode == 200) {
        isLoading.value = false;
        List decoded = json.decode(response.body);

        PropertyList propertiesList = PropertyList.fromJson(decoded);

        propertyList.value = propertiesList.properties;
      }
    } catch (e) {
      print(e);
    }
    // EasyLoading.dismiss();
  }

  void matchingClientsForProperty(propertyId) async {
    isLoading.value = true;

    var response =
        await PropertyListServices.getMatchingClientsForProperty(propertyId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      List decoded = json.decode(response.body);
      matchingClientList.value = decoded;
      isLoading.value = false;
      Get.toNamed(Routes.matchingClients);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      Get.snackbar('Error occured', "Failed to fetch clients list",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
    }
    // matchingClientList = matchingClients;
  }

  void deleteProperty(propertyId, landId, homeId) async {
    // EasyLoading.show(status: 'Loading');
    isLoading.value = true;
    var response =
        await PropertyListServices.deleteProperty(propertyId, landId, homeId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }

    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      // EasyLoading.dismiss();
      isLoading.value = false;
      Get.snackbar('Property deleted', "Property deleted successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      // Get.off(LoginScreen());
      Get.offAndToNamed(Routes.tabScreen);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      isLoading.value = false;
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
    // EasyLoading.show(status: 'Loading');
    isLoading.value = true;

    var response = await PropertyListServices.propertyDetails(propertyId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      propertyDescription.value = decodedResponse;
      Get.toNamed(Routes.propertyDetails);
      isLoading.value = false;
      // EasyLoading.dismiss();
    }
    // print(propertyDescription);
    if ((response.statusCode == 400) || (response.statusCode == 500)) {
      isLoading.value = false;
      Get.snackbar('Error occured', "Failed to fetch property details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
    }
  }

  void getProperty(propertyId) async {
    isLoading.value = true;
    var response = await PropertyListServices.propertyDetails(propertyId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      var propertyDescription = json.decode(response.body);
      var province = propertyDescription["location"]["province"];
      var district = propertyDescription["location"]["district"];
      var municipality = propertyDescription["location"]["municipality"];
      var ward = propertyDescription["location"]["ward"];
      var street = propertyDescription["location"]["street"];
      var latitude = propertyDescription["location"]["latitude"];
      var longitude = propertyDescription["location"]["longitude"];
      var propertyId = propertyDescription["id"];

      var price;
      var landArea;
      var roadAccess;
      var waterSupply;
      var kitchens;
      var bathrooms;
      var bedrooms;
      var floors;
      if (propertyDescription["home"] == null) {
        price = propertyDescription["land"]["price"];
        landArea = propertyDescription["land"]["landArea"];
        roadAccess = propertyDescription["land"]["roadAccess"];
        waterSupply = propertyDescription["land"]["waterSupply"];
        LandController landController = Get.put(LandController());

        landController.clearController();
        landController.setLocationInfo(district, province, municipality, ward,
            street, latitude, longitude);
        landController.setPropertyInfo(
            propertyId, price, landArea, roadAccess, waterSupply);
        landController.editMode.value = true;
        Get.toNamed(Routes.addLand);
      } else {
        price = propertyDescription["home"]["price"];
        landArea = propertyDescription["home"]["landArea"];
        roadAccess = propertyDescription["home"]["roadAccess"];
        waterSupply = propertyDescription["home"]["waterSupply"];
        kitchens = propertyDescription["home"]["kitchens"];
        bathrooms = propertyDescription["home"]["bathrooms"];
        bedrooms = propertyDescription["home"]["bedrooms"];
        floors = propertyDescription["home"]["floors"];
        HomeController homeController = Get.put(HomeController());
        homeController.clearController();
        homeController.setLocationInfo(district, province, municipality, ward,
            street, latitude, longitude);
        homeController.setPropertyInfo(propertyId, price, landArea, roadAccess,
            waterSupply, kitchens, bathrooms, bedrooms, floors);
        homeController.editMode.value = true;
        Get.toNamed(Routes.addHome);
      }

      isLoading.value = false;
    }
    // print(propertyDescription);
    if ((response.statusCode == 400) || (response.statusCode == 500)) {
      isLoading.value = false;
      Get.snackbar('Error occured', "Failed to fetch property details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
    }
  }
}
