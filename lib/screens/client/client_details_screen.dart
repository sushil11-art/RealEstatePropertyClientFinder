import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:get/get.dart';

class ClientDetails extends StatelessWidget {
  // const ClientDetails({Key? key}) : super(key: key);
  final ClientController clientController = Get.put(ClientController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print("yeta chai k vairaxa");
    // print(clientController.clientDescription);
    // print(clientController.clientList);
    var name;
    var email;
    var phone;
    var price;
    var landArea;
    var roadAccess;
    var waterSupply;
    var province;
    var district;
    var municipality;
    var ward;
    var street;
    var kitchens;
    var bathrooms;
    var bedrooms;
    var floors;
    // print(clientController.clientDescription);
    // print(clientController.clientDescription.requiredlocation);
    name = clientController.clientDescription["name"];
    email = clientController.clientDescription["email"];
    phone = clientController.clientDescription["phone"];
    district =
        clientController.clientDescription["requiredlocation"]["district"];
    province =
        clientController.clientDescription["requiredlocation"]["province"];
    municipality =
        clientController.clientDescription["requiredlocation"]["municipality"];
    ward = clientController.clientDescription["requiredlocation"]["ward"];
    street = clientController.clientDescription["requiredlocation"]["street"];

    var propertyType = "Land";
    landArea = clientController.clientDescription["landArea"];
    roadAccess = clientController.clientDescription["roadAccess"];
    waterSupply = clientController.clientDescription["waterSupply"];

    if (clientController.clientDescription["propertyType"] == 1) {
      propertyType = "House";
      kitchens = clientController.clientDescription["kitchens"];
      bathrooms = clientController.clientDescription["bathrooms"];
      bedrooms = clientController.clientDescription["bedrooms"];
      floors = clientController.clientDescription["floors"];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Client Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: height * 0.15,
                width: width * 0.3,
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/userImage.png")
                        // image: AssetImage("assets/images/home.jpg")

                        )),
              ),
            ),
            clientInfo(name, email, phone),
            propertyInfo(propertyType, landArea, roadAccess, waterSupply,
                kitchens, bathrooms, bedrooms, floors),
            locationInfo(district, province, municipality, ward, street)
          ],
        ),
      ),
    );
  }

  Card locationInfo(
      var district, var province, var municipality, var ward, var street) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.directions_train_rounded,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'District:-$district',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.accessibility,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Province:-${province.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.multiline_chart_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Municipality:-$municipality',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.water_damage,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Ward:-$ward',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.streetview,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'Street:-$street',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card propertyInfo(var propertyType, var landArea, var roadAcess,
      var waterSupply, var kitchens, var bathrooms, var bedrooms, var floors) {
    return Card(
        elevation: 10,
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Property Type:- $propertyType',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.landscape,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Land Area:-$landArea${' '}${'aana'}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.bus_alert_outlined,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Road access:-$roadAcess',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.water,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Water Supply:-$waterSupply',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            if (kitchens != null)
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.kitchen,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Kitchens:-$kitchens',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            if (bathrooms != null)
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.bathroom,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Bathrooms:-$bathrooms',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            if (bedrooms != null)
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.bedroom_baby,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Bedrooms:-$bedrooms',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            if (floors != null)
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.folder_open_rounded,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        'Floors:-$floors',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ));
  }

  Card clientInfo(var name, var email, var phone) {
    return Card(
      elevation: 10,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    email.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    phone.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class ClientInfo extends StatelessWidget {
//   const ClientInfo({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
