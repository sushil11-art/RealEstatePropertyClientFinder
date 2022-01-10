import 'package:get/state_manager.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:property_client_finder_app/models/property.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:property_client_finder_app/services/client/client_services.dart';

// import 'package:http/http.dart' as http;
// import 'package:property_client_finder_app/models/property.dart';
// import 'package:property_client_finder_app/services/property/property_list_services.dart';

class ClientController extends GetxController {
  // List propertyList = [].obs;
  var clientList = [].obs;
  var clientDescription = {}.obs;

  // var clientDescription;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchClients();

    super.onInit();
  }

  void fetchClients() async {
    EasyLoading.show(status: 'Loading');

    try {
      var clientsList = await ClientServices.getClients();
      clientList.value = clientsList;
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();
  }

  void deleteClient(clientId) async {
    EasyLoading.show(status: 'Loading');
    var response = await ClientServices.deleteClient(clientId);
    if (response.statusCode == 200) {
      // var data = json.decode(response.body);
      EasyLoading.dismiss();
      Get.snackbar('Client', "Cleint deleted successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      // Get.off(LoginScreen());
      Get.offAndToNamed(Routes.clients);
    }
    if ((response.statusCode == 500) || (response.statusCode == 400)) {
      EasyLoading.dismiss();
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

  void clientDetails(clientId) async {
    EasyLoading.show(status: 'Loading');
    try {
      var response = await ClientServices.clientDetails(clientId);
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        clientDescription.value = decodedResponse;
        clientDescription.refresh();
        print("yo chai controller vitra");
        print(clientDescription);

        Get.offAndToNamed(Routes.clientDetails);
        EasyLoading.dismiss();
      }
      // print(propertyDescription);
      if ((response.statusCode == 400) || (response.statusCode == 500)) {
        EasyLoading.dismiss();
        Get.snackbar('Error occured', "Failed to fetch client details",
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
