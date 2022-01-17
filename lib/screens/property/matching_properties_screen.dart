import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/widgets/property/matching_property_item.dart';
// import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
// import 'package:property_client_finder_app/widgets/property/property_item.dart';

class MatchingProperty extends StatelessWidget {
  const MatchingProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientController clientController = Get.put(ClientController());
    final PropertyListController propertyListController =
        Get.put(PropertyListController());
    return Obx(() => ModalProgressHUD(
          inAsyncCall: propertyListController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
                elevation: 10,
                title: const Text(
                  "Matching Properties",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                backgroundColor: Colors.redAccent),
            body: ListView.builder(
                itemCount: clientController.matchingPropertyList.length,
                itemBuilder: (context, index) {
                  // print(propertyListController.propertyList[index].id);
                  return MatchingPropertyItem(
                      index: index,
                      property: clientController.matchingPropertyList[index]);
                }),
          ),
        ));
    // });
    // });
  }
}
