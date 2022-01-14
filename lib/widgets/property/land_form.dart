import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_client_finder_app/controllers/property/land_controller.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:get/get.dart';
// import 'package:property_client_finder_app/screens/map/map_screen.dart';

class LandForm extends StatelessWidget {
  const LandForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LandController landController = Get.put(LandController());
    return Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: landController.landFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                  controller: landController.priceController,
                  onSaved: (value) {
                    landController.price = value!;
                  },
                  validator: (value) {
                    return landController.validatePriceOrLand(value);
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

                  controller: landController.landAreaController,
                  onSaved: (value) {
                    landController.landArea = value!;
                  },
                  validator: (value) {
                    return landController.validatePriceOrLand(value);
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
                  controller: landController.roadAccessConttroller,
                  onSaved: (value) {
                    landController.roadAccess = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  controller: landController.waterSupplyController,
                  onSaved: (value) {
                    landController.waterSupply = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: landController.provinceController,
                  onSaved: (value) {
                    landController.province = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  controller: landController.districtController,
                  onSaved: (value) {
                    landController.district = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  controller: landController.municipalityController,
                  onSaved: (value) {
                    landController.municipality = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  controller: landController.wardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    landController.ward = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                  controller: landController.streetController,
                  onSaved: (value) {
                    landController.street = value!;
                  },
                  validator: (value) {
                    return landController.validateData(value);
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
                    landController.addLand(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: Center(
                      child: landController.editMode.value
                          ? const Text('Update Land',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ))
                          : const Text('Add Land',
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
