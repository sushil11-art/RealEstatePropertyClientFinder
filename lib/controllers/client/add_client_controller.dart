import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/services/client/client_services.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddClientController extends GetxController {
  GlobalKey<FormState> clientFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // final propertyController = TextEditingController();
  final priceController = TextEditingController();
  final landAreaController = TextEditingController();
  final roadAccessConttroller = TextEditingController();
  final waterSupplyController = TextEditingController();
  final kitchenController = TextEditingController();
  final bathroomController = TextEditingController();
  final bedroomController = TextEditingController();
  final floorController = TextEditingController();

  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final municipalityController = TextEditingController();
  final wardController = TextEditingController();
  final streetController = TextEditingController();

  final box = GetStorage();
  var isLoading = false.obs;

  // true indicate that property is land
  var propertyType = false.obs;

  var editMode = false.obs;

  // String initialCountry = 'NP';
  // PhoneNumber number = PhoneNumber(isoCode: 'NP');

  MapController mapController = Get.put(MapController());

  // ClientController clientController = Get.put(ClientController());
  // ImageUploadController imageUploadController =
  //     Get.put(ImageUploadController());

  // PropertyListController propertyListController =
  //     Get.find<PropertyListController>();
  var clientId;
  var name;
  var email;
  var phone;
  var type;
  var price;
  var landArea;
  var roadAccess;
  var waterSupply;
  var kitchens;
  var bathrooms;
  var bedrooms;
  var floors;
  var province;
  var district;
  var municipality;
  var ward;
  var street;
  var latitude;
  var longitude;

  var propertyCurrentItem = "Land".obs;

  @override
  void onInit() {
    mapController = Get.find<MapController>();
    // clearText();
    // imageUploadController = Get.find<ImageUploadController>();
    // propertyListController = Get.find<PropertyListController>();
    super.onInit();
  }

  @override
  void onClose() {
    // clientController.fetchClients();
    // propertyListController.fetchProperties();
    // clientController.fetchClients();
    // clearText();
    // Get.back();
    Get.reset();
    // super.onClose();
  }

  void clearText() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    priceController.clear();
    landAreaController.clear();
    roadAccessConttroller.clear();
    waterSupplyController.clear();
    kitchenController.clear();
    bathroomController.clear();
    bedroomController.clear();
    floorController.clear();
    provinceController.clear();
    districtController.clear();
    municipalityController.clear();
    wardController.clear();
    streetController.clear();
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

  String? validateEmail(String? value) {
    if (!EmailValidator.validate(value!)) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePhone(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? validatePropertyType(var value) {
    print(value);
    if (value == null) {
      return "Please choose type of your property";
    }
    return null;
  }

  String? validatePriceOrLandOrFloor(String? value) {
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

  void changePropertyType(bool type) {
    propertyType.value = type;
  }

  void addClient(BuildContext context) async {
    var valid = clientFormKey.currentState!.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!valid) {
      return;
    }
    clientFormKey.currentState!.save();

    if ((mapController.latitude) == null ||
        (mapController.longitude) == null ||
        ((mapController.longitude) == null &&
            (mapController.latitude) == null)) {
      Get.snackbar('Error occured', "Please pick a location in map",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      return;
    }
    var latitude = mapController.latitude;
    var longitude = mapController.longitude;

    var phoneNumber = int.parse(phone.substring(phone.length - 10));

    var type = 1;
    if (!(propertyType.value)) {
      kitchens = 0;
      bathrooms = 0;
      bedrooms = 0;
      floors = 0;
      type = 0;
    } else {
      kitchens = int.parse(kitchens);
      bathrooms = int.parse(bathrooms);
      bedrooms = int.parse(bedrooms);
      floors = double.parse(floors);
    }
    // print(propertyType);
    Map data = {
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'price': double.parse(price),
      'propertyType': type,
      'landArea': double.parse(landArea),
      'roadAccess': roadAccess,
      'waterSupply': waterSupply,
      'kitchens': kitchens,
      'bathrooms': bathrooms,
      'bedrooms': bedrooms,
      'floors': floors,
      'province': int.parse(province),
      'district': district,
      'municipality': municipality,
      'ward': int.parse(ward),
      'street': street,
      'latitude': latitude,
      'longitude': longitude,
    };
    // print(data);
    // return;
    isLoading.value = true;
    var response;
    if (editMode.value) {
      response = await ClientServices.editClient(data, clientId);
    } else {
      response = await ClientServices.addClient(data);
    }
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      isLoading.value = false;
      // EasyLoading.dismiss();
      Get.snackbar('Client uploaded', "Client details uploaded successfully",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      clearController();

      // Get.offAndToNamed(Routes.tabScreen);
    }
    if ((response.statusCode == 500) ||
        (response.statusCode == 422) ||
        (response.statusCode == 400)) {
      isLoading.value = false;

      // EasyLoading.dismiss();

      Get.snackbar('Error occured', "Failed to upload client details",
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          margin:
              const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING);
    }
  }

  void clearController() async {
    final ClientController clientController = Get.put(ClientController());
    clientController.fetchClients();
    clearText();
    propertyCurrentItem.value = "Land";
    editMode.value = false;
    propertyType.value = false;
    mapController.location = null;
    mapController.latitude = null;
    mapController.longitude = null;
  }

  void setInitialClientInfo(id, name, email, phone) {
    clientId = id;
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone.toString();
  }

  void setInitialLocation(
      district, province, municipality, ward, street, latitude, longitude) {
    districtController.text = district;
    provinceController.text = province.toString();
    municipalityController.text = municipality;
    wardController.text = ward.toString();
    streetController.text = street;
    mapController.latitude = latitude;
    mapController.longitude = longitude;
    var pos = LatLng(latitude, longitude);
    mapController.selectLocation(pos);
  }

  void setPropertyInfo(typeofProperty, price, landArea, roadAccess, waterSupply,
      kitchens, bathrooms, bedrooms, floors) {
    // propertyType.value = propertyType;
    priceController.text = price.toString();
    landAreaController.text = landArea.toString();
    roadAccessConttroller.text = roadAccess.toString();
    waterSupplyController.text = waterSupply;
    if (typeofProperty == 1) {
      propertyType.value = true;
      propertyCurrentItem.value = "Home";
      kitchenController.text = kitchens.toString();
      bathroomController.text = bathrooms.toString();
      bedroomController.text = bedrooms.toString();
      floorController.text = floors.toString();
    }
  }
}
