import 'package:get/state_manager.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
// import 'package:property_client_finder_app/controllers/auth/login_controller.dart';
import 'package:property_client_finder_app/controllers/client/add_client_controller.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:property_client_finder_app/services/client/client_services.dart';

class ClientController extends GetxController {
  // List propertyList = [].obs;
  var clientList = [].obs;
  var clientDescription = {}.obs;

  var matchingPropertyList = [].obs;

  var isLoading = false.obs;

  AddClientController addClientController = Get.put(AddClientController());

  // var clientDescription;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchClients();
    super.onInit();
  }

  void fetchClients() async {
    // EasyLoading.show(status: 'Loading');
    // print("thiss block is fired");
    isLoading.value = true;
    var response = await ClientServices.getClients();
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      isLoading.value = false;

      List decoded = json.decode(response.body);
      clientList.value = decoded;
    }

    // Get.offAndToNamed(Routes.clients);

    // EasyLoading.dismiss();
  }

  void deleteClient(clientId) async {
    // EasyLoading.show(status: 'Loading');
    isLoading.value = true;
    var response = await ClientServices.deleteClient(clientId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      // EasyLoading.dismiss();
      isLoading.value = false;
      Get.snackbar('Client', "Cleint deleted successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      // Get.off(LoginScreen());
      // Get.offAndToNamed(Routes.clients);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      // EasyLoading.dismiss();
      isLoading.value = true;
      Get.snackbar('Error occured', "Failed to delete client details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
    }
    fetchClients();
    // update();
  }

  void matchingPropertiesForClient(clientId) async {
    isLoading.value = true;

    var response =
        await ClientServices.getMatchingPropertiesForClient(clientId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();
      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      List decoded = json.decode(response.body);
      matchingPropertyList.value = decoded;
      // print(decoded);
      isLoading.value = false;
      Get.toNamed(Routes.matchingProperties);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      Get.snackbar('Error occured', "Failed to fetch properties list",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
    }
    // matchingClientList = matchingClients;
  }

  void clientDetails(clientId) async {
    // EasyLoading.show(status: 'Loading');
    isLoading.value = true;
    try {
      var response = await ClientServices.clientDetails(clientId);
      if (response.statusCode == 401) {
        isLoading.value = false;
        InvalidToken().showSnackBar();

        LogoutController().logout();
      }
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        clientDescription.value = decodedResponse;
        clientDescription.refresh();
        // print("yo chai controller vitra");
        // print(clientDescription);

        Get.toNamed(Routes.clientDetails);
        isLoading.value = false;
        // fetchClients();
        // EasyLoading.dismiss();
      }
      // print(propertyDescription);
      if ((response.statusCode == 400) || (response.statusCode == 500)) {
        // EasyLoading.dismiss();
        isLoading.value = false;
        Get.snackbar('Error occured', "Failed to fetch client details",
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
      }
    } catch (e) {
      isLoading.value = false;
      // EasyLoading.dismiss();
      Get.snackbar('Error occured', "Something went wrong",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
    }
  }

  void getDetails(clientId) async {
    isLoading.value = true;

    var response = await ClientServices.clientDetails(clientId);
    if (response.statusCode == 401) {
      isLoading.value = false;
      InvalidToken().showSnackBar();

      LogoutController().logout();
    }
    if (response.statusCode == 200) {
      var clientDescription = json.decode(response.body);
      var clientId = clientDescription["id"];
      var name = clientDescription["name"];
      var email = clientDescription["email"];
      var phone = clientDescription["phone"];
      var district = clientDescription["requiredlocation"]["district"];
      var province = clientDescription["requiredlocation"]["province"];
      var municipality = clientDescription["requiredlocation"]["municipality"];
      var ward = clientDescription["requiredlocation"]["ward"];
      var street = clientDescription["requiredlocation"]["street"];
      var latitude = clientDescription["requiredlocation"]["latitude"];
      var longitude = clientDescription["requiredlocation"]["longitude"];
      var propertyType = clientDescription["propertyType"];
      var price = clientDescription["price"];
      var landArea = clientDescription["landArea"];
      var roadAccess = clientDescription["roadAccess"];
      var waterSupply = clientDescription["waterSupply"];

      var kitchens = clientDescription["kitchens"];
      var bathrooms = clientDescription["bathrooms"];
      var bedrooms = clientDescription["bedrooms"];
      var floors = clientDescription["floors"];

      addClientController.setInitialClientInfo(clientId, name, email, phone);
      addClientController.setInitialLocation(
          district, province, municipality, ward, street, latitude, longitude);
      addClientController.setPropertyInfo(propertyType, price, landArea,
          roadAccess, waterSupply, kitchens, bathrooms, bedrooms, floors);
      // set edit mode to true;
      addClientController.editMode.value = true;
      Get.toNamed(Routes.addClient);
      isLoading.value = false;

      // isLoading.value = false;
      // fetchClients();
      // EasyLoading.dismiss();
    }
    // print(propertyDescription);
    if ((response.statusCode == 400) || (response.statusCode == 500)) {
      // EasyLoading.dismiss();
      isLoading.value = false;
      Get.snackbar('Error occured', "Failed to fetch client details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
    }
  }
}
