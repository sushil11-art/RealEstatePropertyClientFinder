import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:property_client_finder_app/controllers/property/land_controller.dart';
import 'package:get/get.dart';
// import 'package:property_client_finder_app/helpers/read_json.dart';
import 'package:property_client_finder_app/routes.dart';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:property_client_finder_app/screens/map/selected_map_area.dart';

// import 'package:get/get.dart';
// import 'package:property_client_finder_app/screens/map/map_screen.dart';

class LandForm extends StatefulWidget {
  const LandForm({Key? key}) : super(key: key);

  @override
  State<LandForm> createState() => _LandFormState();
}

class _LandFormState extends State<LandForm> {
  // late List<DropdownMenuItem<String>> _dropDownMenuProvince;
  List<String> _dropDownMenuDistrict = [];
  List<String> _dropDownMenuMunicipality = [];

  // String? _currentProvince;
  // String? _currentDistrict;
  // String? _currentMunicipality;

  List _items = [];

  List province = ["1", "2", "3", "4", "5", "6", "7"];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/address.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
    // print(_items);
  }

  void districtData(String value) {
    // isProvinceSelected = false;
    setState(() {
      _dropDownMenuDistrict = [];
      _dropDownMenuMunicipality = [];
      // _currentDistrict = "";
      // _currentProvince = "";
      var province = int.parse(value.toString());
      // print(_dropDownMenuDistrict);
      var newData =
          _items.where((item) => item["province"] == province).toList();

      var districts = [];
      for (var element in newData) {
        districts.add(element["district"]);
      }
      districts = districts.toSet().toList();

      List<String> districtData = [];
      for (String district in districts) {
        districtData.add(district);
      }
      _dropDownMenuDistrict = districtData;
    });
  }

  void nagarpalikaData(String value) {
    setState(() {
      var district = value.toString();
      var newData =
          _items.where((item) => item["district"] == district).toList();

      var nagarpalika = [];
      for (var element in newData) {
        nagarpalika.add(element["nagarpalika"]);
      }
      nagarpalika = nagarpalika.toSet().toList();
      List<String> nagarpalikaData = [];
      for (String nagarpalika in nagarpalika) {
        nagarpalikaData.add(nagarpalika);
      }
      _dropDownMenuMunicipality = nagarpalikaData;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // readJsonData();
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LandController landController = Get.put(LandController());

    final MapController mapController = Get.put(MapController());
    return Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: landController.landFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                  controller: landController.priceController,
                  onSaved: (value) {
                    landController.price = value!.trim();
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
                    landController.landArea = value!.trim();
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
                    landController.roadAccess = value!.trim();
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
                    landController.waterSupply = value!.trim();
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
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: const ["1", "2", "3", "4", "5", "6", "7"],
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Select Province",
                    prefixIcon: const Icon(Icons.accessibility),
                    labelText: "Province",
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2)),
                  ),
                  selectedItem: landController.province.value.length == 1
                      ? landController.province.value
                      : null,
                  validator: (String? value) {
                    if (value == null) {
                      return "Please select province";
                    } else {
                      return null;
                    }
                  },
                  // selectedItem: landController.province.value,
                  autoValidateMode: AutovalidateMode.always,
                  onSaved: (value) {
                    // print(value);
                    landController.province.value = value!.trim();
                  },
                  onChanged: (value) {
                    districtData(value!);
                    // print(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: _dropDownMenuDistrict,
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Select District",
                    labelText: "District",
                    prefixIcon: const Icon(Icons.directions_transit_sharp),
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2)),
                  ),
                  // validator: (String? value) {
                  //   return landController.validateData(value!);
                  // },
                  selectedItem: landController.district.value.length > 1
                      ? landController.district.value
                      : null,

                  validator: (String? value) {
                    if (value == null) {
                      return "Please select district";
                    } else {
                      return null;
                    }
                  },

                  autoValidateMode: AutovalidateMode.always,
                  onSaved: (String? value) {
                    landController.district.value = value!.trim();
                  },
                  onChanged: (value) {
                    nagarpalikaData(value!);
                    // districtData(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: _dropDownMenuMunicipality,
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Select Municipality",
                    labelText: "Municipality",
                    prefixIcon: const Icon(Icons.multiline_chart_outlined),
                    contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2)),
                  ),
                  validator: (String? value) {
                    if (value == null) {
                      return "Please select municipality";
                    } else {
                      return null;
                    }
                  },
                  selectedItem: landController.municipality.value.length > 1
                      ? landController.municipality.value
                      : null,
                  autoValidateMode: AutovalidateMode.always,
                  onSaved: (value) {
                    landController.municipality.value = value!.trim();
                  },
                  // validator: (value) {
                  //   return landController.validateData(value);
                  // },
                  onChanged: (value) {
                    // nagarpalikaData(value!);
                    // districtData(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: landController.wardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSaved: (value) {
                    landController.ward = value!.trim();
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
                    landController.street = value!.trim();
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
              GetBuilder<MapController>(
                  init: MapController(),
                  builder: (context) {
                    if ((mapController.latitude != null) &&
                        (mapController.longitude != null)) {
                      return SelectedMapArea();
                    } else {
                      return Container();
                    }
                  }),
              Center(
                child: Padding(
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
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                ),
              ),
              Center(
                child: Padding(
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
                ),
              )
            ],
          )),
    );
  }
}
