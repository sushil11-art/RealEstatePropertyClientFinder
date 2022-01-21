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

    return ListView.builder(
        itemCount: propertyListController.propertyList.length,
        itemBuilder: (context, index) {
          return PropertyItem(
              index: index,
              property: propertyListController.propertyList[index]);
        });
    // });
    // });
  }
}
