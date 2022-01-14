import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:property_client_finder_app/controllers/client/add_client_controller.dart';
import 'package:property_client_finder_app/controllers/client/edit_client_controller.dart';
import 'package:property_client_finder_app/routes.dart';

class EditClientScreen extends StatelessWidget {
  // const AddClient({Key? key}) : super(key: key);

  final EditClientController editClientController =
      Get.put(EditClientController());

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Home"), value: "Home"),
      DropdownMenuItem(child: Text("Land"), value: "Land"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: editClientController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
                elevation: 10,
                title: const Text(
                  "Edit Client Requirements",
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
                    key: editClientController.clientEditFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: editClientController.nameController,
                            onSaved: (value) {
                              editClientController.name = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
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
                            controller: editClientController.emailController,
                            onSaved: (value) {
                              editClientController.email = value!;
                            },
                            validator: (value) {
                              return editClientController.validateEmail(value);
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
                                return editClientController
                                    .validatePhone(value);
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
                                  editClientController.phoneController,
                              formatInput: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(width: 2)),
                              onSaved: (number) {
                                editClientController.phone = number.toString();
                                // print('On Saved: $number');
                              },
                              onInputChanged: (PhoneNumber value) {
                                // editClientController.phone = value;
                              },
                            )
                            //  TextFormField(
                            //   keyboardType: TextInputType.number,
                            //   // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                            //   // controller: homeController.priceController,
                            //   // onSaved: (value) {
                            //   //   homeController.price = value!;
                            //   // },
                            //   // validator: (value) {
                            //   //   return homeController.validatePriceOrLandOrFloor(value);
                            //   // },
                            //   decoration: InputDecoration(
                            //       labelText: "Phone",
                            //       prefixIcon: const Icon(Icons.phone_android),
                            //       enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //           borderSide: const BorderSide(width: 2))),
                            // ),
                            ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButtonFormField(
                            onChanged: (value) {
                              print(value);
                              if (value == "Home") {
                                editClientController.changePropertyType(true);
                              } else {
                                editClientController.changePropertyType(false);
                              }
                            },
                            validator: (value) {
                              // print(value);
                              return editClientController
                                  .validatePropertyType(value);
                            },
                            onSaved: (String? value) {
                              // print(value);

                              // editClientController.type = value!.trim();
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
                            controller: editClientController.priceController,
                            onSaved: (value) {
                              editClientController.price = value!;
                            },
                            validator: (value) {
                              return editClientController
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

                            controller: editClientController.landAreaController,
                            onSaved: (value) {
                              editClientController.landArea = value!;
                            },
                            validator: (value) {
                              return editClientController
                                  .validatePriceOrLandOrFloor(value);
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
                            controller:
                                editClientController.roadAccessConttroller,
                            onSaved: (value) {
                              editClientController.roadAccess = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
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
                                editClientController.waterSupplyController,
                            onSaved: (value) {
                              editClientController.waterSupply = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Water Supply",
                                prefixIcon: const Icon(Icons.water_sharp),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        if (editClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  editClientController.kitchenController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                editClientController.kitchens = value!;
                              },
                              validator: (value) {
                                return editClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Kitchens",
                                  prefixIcon: const Icon(Icons.kitchen),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (editClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  editClientController.bathroomController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                editClientController.bathrooms = value!;
                              },
                              validator: (value) {
                                return editClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Bathrooms",
                                  prefixIcon: const Icon(Icons.bathroom),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (editClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  editClientController.bedroomController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onSaved: (value) {
                                editClientController.bedrooms = value!;
                              },
                              validator: (value) {
                                return editClientController.validateData(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "Bedrooms",
                                  prefixIcon: const Icon(Icons.bedroom_baby),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(width: 2))),
                            ),
                          ),
                        if (editClientController.propertyType.value)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: editClientController.floorController,
                              onSaved: (value) {
                                editClientController.floors = value!;
                              },
                              validator: (value) {
                                return editClientController
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: editClientController.provinceController,
                            onSaved: (value) {
                              editClientController.province = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
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
                            controller: editClientController.districtController,
                            onSaved: (value) {
                              editClientController.district = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "District",
                                prefixIcon:
                                    const Icon(Icons.directions_transit_sharp),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller:
                                editClientController.municipalityController,
                            onSaved: (value) {
                              editClientController.municipality = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Municipality",
                                prefixIcon:
                                    const Icon(Icons.multiline_chart_outlined),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 2))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: editClientController.wardController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) {
                              editClientController.ward = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
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
                            controller: editClientController.streetController,
                            onSaved: (value) {
                              editClientController.street = value!;
                            },
                            validator: (value) {
                              return editClientController.validateData(value);
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              editClientController.editClient(context);
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
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
