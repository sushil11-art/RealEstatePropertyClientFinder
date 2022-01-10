import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/property/add_land_screen.dart';
import 'package:property_client_finder_app/screens/property/property_list_screen.dart';
import 'package:property_client_finder_app/widgets/navigation/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.red),
          ),
          title: const Text(
            'Real Estate',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.red,
                ))
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.addLand);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Add Land',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.addHome);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Add Home',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              Expanded(child: PropertyList())
            ],
          ),
        ));
  }
}
