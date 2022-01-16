import 'package:flutter/material.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
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
    {'page': Settings(), 'title': 'Settings'},
    {
      'page': ClientScreen(),
      'title': 'Clients',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.red),
        ),
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
              color: Colors.black,
              fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                LogoutController().logout();
                // Restart.restartApp(webOrigin: Routes.login);
                // Get.offAllNamed(Routes.login);
                // Get.offNamedUntil(Routes.login, (route) => true);
                // Get.back();
                // logoutController.logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        // onTap: controller.changeTabIndex,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clients',
          ),
        ],
      ),
    );
  }
}
