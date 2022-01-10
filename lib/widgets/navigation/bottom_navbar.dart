import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientController clientController = Get.put(ClientController());
    return Container(
      // padding: EdgeInsets.only(
      //   top: 20,
      //   left: 40,
      //   right: 40,
      //   bottom: 30,
      // ),
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, -10),
        //     blurRadius: 35,
        //     color: Colors.redAccent,
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.house,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 30,
              ),
              onPressed: () {
                // clientController.clientList();
                Get.offAndToNamed(Routes.clients);
              },
            ),
          ),
        ],
      ),
    );
  }
}
