import 'package:flutter/material.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/widgets/client/client_list.dart';
import 'package:property_client_finder_app/widgets/navigation/bottom_navbar.dart';
import 'package:get/get.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Clients',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.offAndToNamed(Routes.home);
          },
        ),
      ),
      body: Column(
        children: [Expanded(child: ClientList())],
      ),
      // bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
