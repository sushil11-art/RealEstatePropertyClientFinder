import 'package:flutter/material.dart';
// import 'package:blurry/blurry.dart';
import 'package:get/state_manager.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:get/get.dart';
// import 'package:property_client_finder_app/routes.dart';

class ClientList extends StatelessWidget {
  final ClientController clientController = Get.put(ClientController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: clientController.clientList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 6,
            child: ListTile(
                onTap: () {
                  clientController.matchingPropertiesForClient(
                      clientController.clientList[index]["id"]);

                  // Get.offAndToNamed(Routes.clientDetails);
                },
                leading: const CircleAvatar(
                  // child: Text('1'),
                  backgroundImage: AssetImage("assets/images/userImage.png"),
                  backgroundColor: Colors.purple,
                ),
                title: Text(clientController.clientList[index]["name"],
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                subtitle: Text(clientController.clientList[index]["email"],
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black)),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  // Text('Land'),
                  IconButton(
                    icon:
                        const Icon(Icons.details_outlined, color: Colors.blue),
                    onPressed: () {
                      clientController.clientDetails(
                          clientController.clientList[index]["id"]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      clientController
                          .getDetails(clientController.clientList[index]["id"]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              const Color.fromRGBO(255, 253, 208, 1),
                          builder: (BuildContext context) {
                            return Wrap(children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                leading: const Icon(
                                  Icons.cancel,
                                  color: Colors.green,
                                ),
                                title: const Text('Cancel'),
                              ),
                              ListTile(
                                onTap: () {
                                  clientController.deleteClient(
                                      clientController.clientList[index]["id"]);
                                  Navigator.pop(context);
                                },
                                leading: const Icon(Icons.confirmation_num,
                                    color: Colors.red),
                                title: const Text('Confirm'),
                              ),
                            ]);
                          });
                    },
                  ),
                ])),
          );
        });
  }
}
