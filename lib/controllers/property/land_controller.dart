import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/controllers/upload/upload_file_controller.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:property_client_finder_app/services/property/land_services.dart';
import 'package:property_client_finder_app/services/upload/image_upload_services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// integrate google map flutter
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';

// import 'dart:async';

class LandController extends GetxController {
  final landFormKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final landAreaController = TextEditingController();
  final ropaniController = TextEditingController();
  final aanaController = TextEditingController();

  final roadAccessConttroller = TextEditingController();
  final waterSupplyController = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final municipalityController = TextEditingController();
  final wardController = TextEditingController();
  final streetController = TextEditingController();

  final box = GetStorage();
  var isLoading = false.obs;
  var editMode = false.obs;

  MapController mapController = Get.put(MapController());
  ImageUploadController imageUploadController =
      Get.put(ImageUploadController());

  PropertyListController propertyListController =
      Get.find<PropertyListController>();

  var propertyId;

  var price;
  var landArea;
  var ropani;
  var aana;
  var roadAccess;
  var waterSupply;
  var province = "".obs;
  var district = "".obs;
  var municipality = "".obs;
  var ward;
  var street;

  var latitude;
  var longitude;
  @override
  void onInit() {
    mapController = Get.find<MapController>();
    imageUploadController = Get.find<ImageUploadController>();
    // propertyListController = Get.find<PropertyListController>();
    super.onInit();
  }

  @override
  void onClose() {
    priceController.dispose();
    landAreaController.dispose();
    roadAccessConttroller.dispose();
    waterSupplyController.dispose();
    provinceController.dispose();
    districtController.dispose();
    municipalityController.dispose();
    wardController.dispose();
    streetController.dispose();
    propertyListController.fetchProperties();
    // getProfile.profileDetails();
    super.onClose();
  }

  String? validateData(String? value) {
    if (value!.isEmpty) {
      return "Please fill up above details";
    }
    // if (!EmailValidator.validate(value!)) {
    //   return "Please enter email";
    // }
    return null;
  }

  String? validatePriceOrLand(String? value) {
    try {
      var data = double.parse(value!);
      if (data is double) {
        return null;
      }
    } catch (e) {
      return "Please enter correct details";
    }

    // assert(myDouble is double);
    // print(myDoublse); //
  }

  // ignore: dead_code
  void addLand(BuildContext context) async {
    try {
      var valid = landFormKey.currentState!.validate();
      FocusScope.of(context).requestFocus(FocusNode());
      if (!valid) {
        return;
      }
      landFormKey.currentState!.save();
      List<String> images = [];

      // get imageUploadController

      // get mapController
      // final MapController mapController = Get.put(MapController());

      // check whether user has uploaded images or not
      if (imageUploadController.imageFileList!.isEmpty) {
        // check whether user upload at least one image or not
        Get.snackbar(
            'Error occured', "Upload at least one image of your property",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        return;
      }

      // check whether user has picked location or not

      // if(){

      // }
      // print(mapController.latitude);
      // print(mapController.longitude);

      if ((mapController.latitude) == null ||
          (mapController.longitude) == null ||
          ((mapController.longitude) == null &&
              (mapController.latitude) == null)) {
        Get.snackbar('Error occured', "Please pick a location in map",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        return;
      }
      // store latitude and longitude in vairable
      isLoading.value = true;
      // EasyLoading.show(status: 'Loading');
      var res = await ImageUploadServices.uploadImages(
          imageUploadController.imageFileList!);
      var responseData = await http.Response.fromStream(res);
      var decodedData = json.decode(responseData.body) as Map<String, dynamic>;
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
      var latitude = mapController.latitude;
      var longitude = mapController.longitude;
      Map data = {
        'price': double.parse(price),
        'ropani': double.parse(ropani),
        'aana': double.parse(aana),
        // 'landArea': double.parse(landArea),
        'roadAccess': roadAccess,
        'waterSupply': waterSupply,
        'province': int.parse(province.value),
        'district': district.value,
        'municipality': municipality.value,
        'ward': int.parse(ward),
        'street': street,
        'latitude': latitude,
        'longitude': longitude,
        'images': images
      };
      var response;
      if (editMode.value) {
        response = await LandServices.editLand(data, propertyId);
      } else {
        response = await LandServices.addLand(data);
      }
      if (response.statusCode == 401) {
        isLoading.value = false;
        InvalidToken().showSnackBar();
        LogoutController().logout();
        return;
      }
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // EasyLoading.dismiss();
        isLoading.value = false;

        Get.snackbar('Property uploaded', "Land details uploaded successfully",
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        // Get.off(LoginScreen());
        clearController();
        GetProfile getProfile = Get.put(GetProfile());
        getProfile.profileDetails();
        Get.offAndToNamed(Routes.tabScreen);
      }
      if ((response.statusCode == 500) || (response.statusCode == 422)) {
        // EasyLoading.dismiss();
        isLoading.value = false;
        Get.snackbar('Error occured', "Failed to upload property details",
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

  void setPropertyInfo(id, price, landArea, roadAccess, waterSupply) async {
    propertyId = id;
    priceController.text = price.toString();
    landAreaController.text = landArea.toString();
    roadAccessConttroller.text = roadAccess.toString();
    waterSupplyController.text = waterSupply;
  }

  void setLocationInfo(dist, prov, muni, ward, street, latitude, longitude) {
    district.value = dist;
    province.value = prov.toString();
    municipality.value = muni;
    wardController.text = ward.toString();
    streetController.text = street;
    mapController.latitude = latitude;
    mapController.longitude = longitude;
    var pos = LatLng(latitude, longitude);
    mapController.selectLocation(pos);
  }

  void clearText() {
    priceController.clear();
    landAreaController.clear();
    ropaniController.clear();
    aanaController.clear();
    roadAccessConttroller.clear();
    waterSupplyController.clear();
    // kitchenController.clear();
    // bathroomController.clear();
    // bedroomController.clear();
    // floorController.clear();
    province.value = "";
    district.value = "";
    municipality.value = "";
    // provinceController.clear();
    // districtController.clear();
    // municipalityController.clear();
    wardController.clear();
    streetController.clear();
  }

  void clearController() {
    final PropertyListController propertyListController =
        Get.put(PropertyListController());
    propertyListController.fetchProperties();
    clearText();
    // propertyCurrentItem.value = "Land";
    editMode.value = false;
    // propertyType.value = false;
    imageUploadController.imageFileList = [];
    mapController.location = null;
    mapController.latitude = null;
    mapController.longitude = null;
  }
}
