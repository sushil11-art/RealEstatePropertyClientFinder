import 'package:flutter/material.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/navigation.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
// import 'package:property_client_finder_app/widgets/auth/login_form.dart';
import 'package:get/get.dart';
// import 'package:property_client_finder_app/screens/home/home_screen.dart';
// import 'package:property_client_finder_app/screens/property/add_land_screen.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:property_client_finder_app/services/auth/auth_services.dart';
// import 'package:property_client_finder_app/services/property/property_list_services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await Get.putAsync(() => AuthService().init());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isToken = false;

  @override
  void initState() {
    // TODO: implement initState
    checkToken();
    super.initState();
  }

  void checkToken() async {
    final box = GetStorage();
    var token = box.read('token');
    if (token != null) {
      setState(() {
        isToken = true;
      });
    }
  }

  // Future checkStatus() async {
  //   final response = await PropertyListServices.getProperties();
  //   if (response.statusCode == 401) {
  //     setState(() {
  //       isValidToken = false;
  //     });
  //     Get.snackbar('Invalid token', "Login session expired",
  //         duration: const Duration(seconds: 5),
  //         backgroundColor: Colors.red,
  //         margin:
  //             const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
  //         snackPosition: SnackPosition.BOTTOM,
  //         snackStyle: SnackStyle.FLOATING);
  //     LogoutController().logout();
  //   }
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       isValidToken = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Property Client Finder',
        // key: myAppKey,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        initialRoute: isToken ? Routes.tabScreen : Routes.login,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        getPages: appPages);
  }
}
