import 'package:flutter/material.dart';
import 'package:blurry/blurry.dart';
import 'package:get/state_manager.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/routes.dart';

class ClientList extends StatelessWidget {
  // const ClientList({Key? key}) : super(key: key);
  // ClientList({required this.clientController});
  // ClientController clientController;
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
                  clientController
                      .clientDetails(clientController.clientList[index]["id"]);
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
                    icon: const Icon(Icons.edit, color: Colors.redAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      clientController.deleteClient(
                          clientController.clientList[index]["id"]);
                      // Blurry(
                      //     icon: Icons.delete,
                      //     themeColor: Colors.pink,
                      //     title: 'Delete Client',
                      //     description: 'Remove your client?',
                      //     confirmButtonText: 'Confirm',
                      //     onConfirmButtonPressed: () {
                      //       clientController.deleteClient(
                      //           clientController.clientList[index]["id"]);
                      //     }).show(context);
                      // Navigator.pop(context);
                    },
                  ),
                ])),
          );
        });
  }
}
