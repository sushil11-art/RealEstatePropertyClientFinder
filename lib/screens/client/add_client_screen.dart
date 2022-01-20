import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/controllers/client/add_client_controller.dart';
import 'package:property_client_finder_app/routes.dart';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:property_client_finder_app/screens/map/selected_map_area.dart';

class AddClient extends StatefulWidget {
  // const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final AddClientController addClientController =
      Get.put(AddClientController());

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Home"), value: "Home"),
      DropdownMenuItem(child: Text("Land"), value: "Land"),
    ];
    return menuItems;
  }

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   addClientController.clearController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());
    return Obx(() => ModalProgressHUD(
          inAsyncCall: addClientController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
                elevation: 10,
                title: addClientController.editMode.value
                    ? const Text(
                        "Edit Client Requirements",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      )
                    : const Text(
                        "Add Client Requirements",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                backgroundColor: Colors.redAccent),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Form(
                    key: addClientController.clientFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: addClientController.nameController,
                            onSaved: (value) {
                              addClientController.name = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Name",
                                prefixIcon: const Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: addClientController.emailController,
                            onSaved: (value) {
                              addClientController.email = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateEmail(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: const Icon(Icons.email),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: InternationalPhoneNumberInput(
                              // onInputChanged: (PhoneNumber number) {
                              //   // print(number.phoneNumber);
                              // },
                              validator: (value) {
                                return addClientController.validatePhone(value);
                              },
                              // onInputValidated: (value) {
                              //   print(value);
                              // },
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              // ignoreBlank: false,
                              // autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),

                              // initialValue: number,
                              textFieldController:
                                  addClientController.phoneController,
                              formatInput: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 2)),
                              onSaved: (number) {
                                addClientController.phone = number.toString();
                                // print('On Saved: $number');
                              },
                              onInputChanged: (PhoneNumber value) {
                                // addClientController.phone = value;
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                            autovalidateMode: AutovalidateMode.always,
                            value:
                                addClientController.propertyCurrentItem.value,
                            onChanged: (value) {
                              print(value);
                              if (value == "Home") {
                                addClientController.changePropertyType(true);
                              } else {
                                addClientController.changePropertyType(false);
                              }
                            },
                            validator: (value) {
                              // print(value);
                              return addClientController
                                  .validatePropertyType(value);
                            },
                            onSaved: (value) {
                              // print(value);

                              // addClientController.type = value!.trim().trim();
                            },
                            items: dropdownItems,
                            decoration: InputDecoration(
                                labelText: "Property Type",
                                prefixIcon: const Icon(Icons.home_filled),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                            controller: addClientController.priceController,
                            onSaved: (value) {
                              addClientController.price = value!.trim();
                            },
                            validator: (value) {
                              return addClientController
                                  .validatePriceOrLandOrFloor(value);
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

                            controller: addClientController.ropaniController,
                            onSaved: (value) {
                              addClientController.ropani = value!.trim();
                            },
                            validator: (value) {
                              return addClientController
                                  .validatePriceOrLandOrFloor(value);
                            },
                            // obscureText: true,
                            decoration: InputDecoration(
                                // suffixIcon: const Icon(Icons.landscape_rounded),
                                prefixIcon: const Icon(Icons.landscape_rounded),
                                labelText: "Ropani",
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

                            controller: addClientController.aanaController,
                            onSaved: (value) {
                              addClientController.aana = value!.trim();
                            },
                            validator: (value) {
                              return addClientController
                                  .validatePriceOrLandOrFloor(value);
                            },
                            // obscureText: true,
                            decoration: InputDecoration(
                                // suffixIcon: const Icon(Icons.landscape_rounded),
                                prefixIcon: const Icon(Icons.archive_sharp),
                                labelText: "Aana",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            // keyboardType: TextInputType.number,
                            controller:
                                addClientController.roadAccessConttroller,
                            onSaved: (value) {
                              addClientController.roadAccess = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Road Access",
                                prefixIcon:
                                    const Icon(Icons.directions_bus_rounded),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller:
                                addClientController.waterSupplyController,
                            onSaved: (value) {
                              addClientController.waterSupply = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Water Supply",
                                prefixIcon: const Icon(Icons.water_sharp),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        if (addClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: addClientController.kitchenController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                addClientController.kitchens = value!.trim();
                              },
                              validator: (value) {
                                return addClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Kitchens",
                                  prefixIcon: const Icon(Icons.kitchen),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (addClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  addClientController.bathroomController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                addClientController.bathrooms = value!.trim();
                              },
                              validator: (value) {
                                return addClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Bathrooms",
                                  prefixIcon: const Icon(Icons.bathroom),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (addClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: addClientController.bedroomController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                addClientController.bedrooms = value!.trim();
                              },
                              validator: (value) {
                                return addClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Bedrooms",
                                  prefixIcon: const Icon(Icons.bedroom_baby),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (addClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: addClientController.floorController,
                              onSaved: (value) {
                                addClientController.floors = value!.trim();
                              },
                              validator: (value) {
                                return addClientController
                                    .validatePriceOrLandOrFloor(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Floors",
                                  prefixIcon:
                                      const Icon(Icons.folder_open_rounded),
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 0, 0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 2)),
                            ),
                            validator: (String? value) {
                              if (value == null) {
                                return "Please select province";
                              } else {
                                return null;
                              }
                            },
                            selectedItem:
                                addClientController.province.value.length == 1
                                    ? addClientController.province.value
                                    : null,
                            autoValidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              // print(value);
                              addClientController.province.value =
                                  value!.trim();
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
                              prefixIcon:
                                  const Icon(Icons.directions_transit_sharp),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 0, 0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 2)),
                            ),
                            // validator: (String? value) {
                            //   return addClientController.validateData(value!);
                            // },
                            selectedItem:
                                addClientController.district.value.length > 1
                                    ? addClientController.district.value
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
                              addClientController.district.value =
                                  value!.trim();
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
                              prefixIcon:
                                  const Icon(Icons.multiline_chart_outlined),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                            selectedItem:
                                addClientController.municipality.value.length >
                                        1
                                    ? addClientController.municipality.value
                                    : null,

                            autoValidateMode: AutovalidateMode.always,
                            onSaved: (value) {
                              addClientController.municipality.value =
                                  value!.trim();
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
                            controller: addClientController.wardController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) {
                              addClientController.ward = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateData(value);
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
                            controller: addClientController.streetController,
                            onSaved: (value) {
                              addClientController.street = value!.trim();
                            },
                            validator: (value) {
                              return addClientController.validateData(value);
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        ),
                        addClientController.editMode.value
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addClientController.addClient(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    child: const Center(
                                      child: Text('Update Client',
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
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    addClientController.addClient(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    child: const Center(
                                      child: Text('Add Client',
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
              ),
            ),
          ),
        ));
  }
}
