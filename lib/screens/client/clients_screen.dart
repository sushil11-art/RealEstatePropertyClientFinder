import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/controllers/client/add_client_controller.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/widgets/client/client_list.dart';
// import 'package:property_client_finder_app/widgets/navigation/bottom_navbar.dart';
import 'package:get/get.dart';

class ClientScreen extends StatelessWidget {
  // const ClientScreen({Key? key}) : super(key: key);
  final ClientController clientController = Get.put(ClientController());
  final AddClientController addClientController =
      Get.put(AddClientController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: clientController.isLoading.value,
          child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   title: const Text('Clients',
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold, color: Colors.black)),
            //   leading: IconButton(
            //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            //     onPressed: () {
            //       Get.offAndToNamed(Routes.home);
            //     },
            //   ),
            // ),
            body: Column(
              children: [Expanded(child: ClientList())],
            ),
            // bottomNavigationBar: BottomNavBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Colors.red,
              onPressed: () {
                addClientController.clearController();
                Get.toNamed(Routes.addClient);
              },
            ),
          ),
        ));
  }
}
