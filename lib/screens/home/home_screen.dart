import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/property/home_controller.dart';
import 'package:property_client_finder_app/controllers/property/land_controller.dart';
// import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/property/add_land_screen.dart';
import 'package:property_client_finder_app/screens/property/property_list_screen.dart';
// import 'package:property_client_finder_app/widgets/navigation/bottom_navbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  // const EditProfile({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
  final PropertyListController propertyListController =
      Get.put(PropertyListController());
  LandController landController = Get.put(LandController());
  HomeController homeController = Get.put(HomeController());
  // final ClientController clientController = Get.put(ClientController());

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: propertyListController.isLoading.value,
          child: Scaffold(
              body: Column(
                children: [
                  // if (propertyListController.isFloatingButtonPressed.value)
                  //   Container(
                  //     margin: const EdgeInsets.all(30),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       // mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         ElevatedButton(
                  //             onPressed: () {
                  //               landController.clearController();
                  //               Get.toNamed(Routes.addLand);
                  //             },
                  //             style: ElevatedButton.styleFrom(
                  //               primary: Colors.red[600],
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(25),
                  //               ),
                  //             ),
                  //             child: const Text(
                  //               'Add Land',
                  //               style: TextStyle(color: Colors.white),
                  //             )),
                  //         ElevatedButton(
                  //             onPressed: () {
                  //               homeController.clearController();
                  //               Get.toNamed(Routes.addHome);
                  //             },
                  //             style: ElevatedButton.styleFrom(
                  //               primary: Colors.black,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(25),
                  //               ),
                  //             ),
                  //             child: const Text(
                  //               'Add Home',
                  //               style: TextStyle(color: Colors.white),
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  Expanded(child: PropertyList())
                ],
              ),
              floatingActionButton: Wrap(
                //will break to another line on overflow
                direction:
                    Axis.vertical, //use vertical to show  on vertical axis
                children: <Widget>[
                  //button first
                  if (propertyListController.isFloatingButtonPressed.value)
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FloatingActionButton.extended(
                            label: const Text('Add Land'),
                            heroTag: 'landBtn',
                            onPressed: () {
                              landController.clearController();
                              Get.toNamed(Routes.addLand);
                              //action code for button 2
                            },
                            backgroundColor: Colors.red,
                            icon: const Icon(
                                Icons.landscape_outlined))), // button second
                  if (propertyListController.isFloatingButtonPressed.value)
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FloatingActionButton.extended(
                          label: const Text('Add Home'),
                          heroTag: 'homeBtn',
                          onPressed: () {
                            homeController.clearController();
                            Get.toNamed(Routes.addHome);
                            //action code for button 3
                          },
                          backgroundColor: Colors.deepOrangeAccent,
                          icon: const Icon(Icons.home),
                        )),

                  Container(
                      margin: const EdgeInsets.all(10),
                      child: FloatingActionButton.extended(
                        heroTag: 'propertyBtn',
                        backgroundColor: Colors.redAccent,
                        label:
                            propertyListController.isFloatingButtonPressed.value
                                ? const Text('Close')
                                : const Text('Property'),
                        onPressed: () {
                          propertyListController.toggleFloatingActionButton();
                          //action code for button 1
                        },
                        icon:
                            propertyListController.isFloatingButtonPressed.value
                                ? const Icon(Icons.close)
                                : const Icon(Icons.add),
                      )), // button third

                  // Add more buttons here
                ],
                // floatingActionButton: FloatingActionButton(
                //     onPressed: () {
                //       propertyListController.toggleFloatingActionButton();
                //     },
                //     child: propertyListController.isFloatingButtonPressed.value
                //         ? const Icon(Icons.close)
                //         : const Icon(Icons.add),
                //     backgroundColor: Colors.red)
                //   floatingActionButton: SpeedDial(
                //     animatedIcon: AnimatedIcons.menu_close,
                //     openCloseDial: isDialOpen,
                //     backgroundColor: Colors.red,
                //     overlayColor: Colors.grey,
                //     overlayOpacity: 0.5,
                //     spacing: 15,
                //     spaceBetweenChildren: 15,
                //     closeManually: true,
                //     children: [
                //       SpeedDialChild(
                //           child: const Icon(Icons.landscape_rounded,
                //               color: Colors.redAccent),
                //           label: 'Add Land',
                //           onTap: () {
                //             setState((){
                //                     if(isDialOpen.value){
                // isDialOpen.value = false;}
                //             });

                //             landController.clearController();
                //             Get.toNamed(Routes.addLand);

                //             //             Get.toNamed(Routes.addLand);
                //             // print('Share Tapped');
                //           }),
                //       SpeedDialChild(
                //           child: const Icon(Icons.home, color: Colors.redAccent),
                //           label: 'Add Home',
                //           onTap: () {
                //              setState((){
                //                     if(isDialOpen.value){
                // isDialOpen.value = false;}
                //             });
                //             homeController.clearController();
                //             Get.toNamed(Routes.addHome);
                //             // print('Mail Tapped');
                //           }),
                //     ],
                //   ),

                // onPressed: () {},
                // backgroundColor: Colors.red,
                // child: const Icon(Icons.add),
              )),
        ));
  }
}
