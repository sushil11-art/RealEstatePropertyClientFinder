import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_client_finder_app/controllers/property/home_controller.dart';
// import 'package:property_client_finder_app/controllers/property/land_controller.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:get/get.dart';
// import 'package:property_client_finder_app/screens/map/map_screen.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: homeController.homeFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                  controller: homeController.priceController,
                  onSaved: (value) {
                    homeController.price = value!;
                  },
                  validator: (value) {
                    return homeController.validatePriceOrLandOrFloor(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Price",
                      prefixIcon: const Icon(Icons.money),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  controller: homeController.landAreaController,
                  onSaved: (value) {
                    homeController.landArea = value!;
                  },
                  validator: (value) {
                    return homeController.validatePriceOrLandOrFloor(value);
                  },
                  // obscureText: true,
                  decoration: InputDecoration(
                      // suffixIcon: const Icon(Icons.landscape_rounded),
                      prefixIcon: const Icon(Icons.landscape_rounded),
                      labelText: "Land Area",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  // keyboardType: TextInputType.number,
                  controller: homeController.roadAccessConttroller,
                  onSaved: (value) {
                    homeController.roadAccess = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Road Access",
                      prefixIcon: const Icon(Icons.directions_bus_rounded),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: homeController.waterSupplyController,
                  onSaved: (value) {
                    homeController.waterSupply = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Water Supply",
                      prefixIcon: const Icon(Icons.water_sharp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: homeController.kitchenController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    homeController.kitchens = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Kitchens",
                      prefixIcon: const Icon(Icons.kitchen),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: homeController.bathroomController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    homeController.bathrooms = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Bathrooms",
                      prefixIcon: const Icon(Icons.bathroom),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: homeController.bedroomController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    homeController.bedrooms = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Bedrooms",
                      prefixIcon: const Icon(Icons.bedroom_baby),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: homeController.floorController,
                  onSaved: (value) {
                    homeController.floors = value!;
                  },
                  validator: (value) {
                    return homeController.validatePriceOrLandOrFloor(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Floors",
                      prefixIcon: const Icon(Icons.folder_open_rounded),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: homeController.provinceController,
                  onSaved: (value) {
                    homeController.province = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Province",
                      prefixIcon: const Icon(Icons.accessibility),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: homeController.districtController,
                  onSaved: (value) {
                    homeController.district = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "District",
                      prefixIcon: const Icon(Icons.directions_transit_sharp),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: homeController.municipalityController,
                  onSaved: (value) {
                    homeController.municipality = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Municipality",
                      prefixIcon: const Icon(Icons.multiline_chart_outlined),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: homeController.wardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    homeController.ward = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Ward",
                      prefixIcon: const Icon(Icons.water_damage),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: homeController.streetController,
                  onSaved: (value) {
                    homeController.street = value!;
                  },
                  validator: (value) {
                    return homeController.validateData(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Street",
                      prefixIcon: const Icon(Icons.streetview),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton.icon(
                    onPressed: () {
                      // Get.off(MapScreen());
                      Get.toNamed(Routes.picklocation);
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 20,
                    ),
                    label: const Text('Pick location in map',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    homeController.addHome(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: const Center(
                      child: Text('Add Land',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
