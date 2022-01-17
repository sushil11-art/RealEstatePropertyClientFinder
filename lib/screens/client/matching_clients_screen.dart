import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:get/get.dart';

class MatchingClients extends StatelessWidget {
  // const MatchingClients({Key? key}) : super(key: key);
  final PropertyListController propertyListController =
      Get.put(PropertyListController());
  final ClientController clientController = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: clientController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(
                  elevation: 10,
                  title: const Text(
                    "Matching Clients",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  backgroundColor: Colors.redAccent),
              body: ListView.builder(
                  itemCount: propertyListController.matchingClientList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 6,
                      child: ListTile(
                          onTap: () {
                            clientController.clientDetails(
                                propertyListController.matchingClientList[index]
                                    ["id"]);
                          },
                          leading: const CircleAvatar(
                            // child: Text('1'),
                            backgroundImage:
                                AssetImage("assets/images/userImage.png"),
                            backgroundColor: Colors.purple,
                          ),
                          title: Text(
                              propertyListController.matchingClientList[index]
                                  ["name"],
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          subtitle: Text(
                              propertyListController.matchingClientList[index]
                                  ["email"],
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.person,
                                    color: Colors.red, size: 30)
                              ])),
                    );
                  })),
        ));
  }
}
