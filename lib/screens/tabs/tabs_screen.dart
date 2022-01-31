import 'package:flutter/material.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
// import 'package:property_client_finder_app/config/logout_controller.dart';
// import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/auth/login_screen.dart';
// import 'package:property_client_finder_app/controllers/tabs/tab_controller.dart';
import 'package:property_client_finder_app/screens/client/clients_screen.dart';
import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/screens/settings/setting_screen.dart';
import 'package:property_client_finder_app/services/property/property_list_services.dart';
// import 'package:restart_app/restart_app.dart';

class TabScreen extends StatefulWidget {
  // const TabScreen({Key? key}) : super(key: key);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // final LogoutController logoutController = Get.put(LogoutController());
  int _selectedPageIndex = 0;

  // Future checkStatus() async {
  //   final response = await PropertyListServices.getProperties();
  //   if (response.statusCode == 401) {
  //     Get.snackbar('Invalid token', "Login session expired",
  //         duration: const Duration(seconds: 5),
  //         backgroundColor: Colors.red,
  //         margin:
  //             const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
  //         snackPosition: SnackPosition.BOTTOM,
  //         snackStyle: SnackStyle.FLOATING);
  //     LogoutController().logout();
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // if (response.statusCode == 401) {
  //   //   LogoutController().logout();
  //   // }
  //   checkStatus();
  //   super.initState();
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Real Estate',
    },
    {'page': ClientScreen(), 'title': 'Clients'},
    {
      'page': Settings(),
      'title': 'Profile',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final PropertyListController propertyListController =
        Get.put(PropertyListController());
    return WillPopScope(
        onWillPop: () async {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text('The System Back Button is Deactivated')));
          return false;
        },
        child: Obx(
          () => AbsorbPointer(
            absorbing: propertyListController.isLoading.value,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                automaticallyImplyLeading: false,
                title: Text(
                  _pages[_selectedPageIndex]['title'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 20),
                ),
                // actions: [
                //   IconButton(
                //       onPressed: () {
                //         LogoutController().logout();
                //         // LogoutController().logoutContext(context);
                //         // Restart.restartApp(webOrigin: Routes.login);
                //         // Get.offAllNamed(Routes.login);
                //         // Get.offNamedUntil(Routes.login, (route) => true);
                //         // Get.back();
                //         // logoutController.logout();
                //       },
                //       icon: const Icon(
                //         Icons.logout,
                //         color: Colors.black,
                //       ))
                // ],
              ),
              // floatingActionButton: _selectedPageIndex == 0
              //     ? FloatingActionButton(
              //         onPressed: () {},
              //         backgroundColor: Colors.red,
              //         child: const Icon(Icons.add),
              //       )
              //     : null,
              body: _pages[_selectedPageIndex]['page'] as Widget,
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.black,
                // onTap: controller.changeTabIndex,
                onTap: _selectPage,
                currentIndex: _selectedPageIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Clients',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
