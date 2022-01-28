import 'package:flutter/material.dart';
// import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/config/shared_preferences.dart';
// import 'package:property_client_finder_app/models/home.dart';
import 'package:property_client_finder_app/navigation.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
import 'package:property_client_finder_app/screens/tabs/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'package:property_client_finder_app/services/auth/auth_services.dart';
// import 'package:property_client_finder_app/services/property/property_list_services.dart';
import 'package:get_storage/get_storage.dart';

// bool isLoggegIn = false;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AuthService().init());
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString('userToken');
  // print(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storeManager = StorageManager();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Property Client Finder',
        // key: myAppKey,
        home: FutureBuilder(
            future: storeManager.tryAutoLogin(),
            builder: (context, authResult) {
              if (authResult.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                );
              } else {
                if (authResult.data == true) {
                  return TabScreen();
                }
                return LoginScreen();
              }
            }),
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        // initialRoute: Routes.login,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        getPages: appPages);
  }
}
