import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/widgets/property/property_item.dart';

class PropertyList extends StatelessWidget {
  const PropertyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PropertyListController propertyListController =
        Get.put(PropertyListController());

    // return GetBuilder<PropertyListController>(
    //     init: PropertyListController(),
    //     builder: (context) {
    // if (propertyListController.propertyList.isEmpty) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // return GetX<PropertyListController>(builder: (controller) {
    return Obx(() => ListView.builder(
        // shrinkWrap: true,
        // primary: false,
        // scrollDirection: Axis.vertical,
        itemCount: propertyListController.propertyList.length,
        itemBuilder: (context, index) {
          // print(propertyListController.propertyList[index].id);
          return PropertyItem(
              index: index,
              property: propertyListController.propertyList[index]);
        }));
    // });
    // });
  }
}
