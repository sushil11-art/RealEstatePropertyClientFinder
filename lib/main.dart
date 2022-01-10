import 'package:flutter/material.dart';
import 'package:property_client_finder_app/navigation.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
// import 'package:property_client_finder_app/widgets/auth/login_form.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:property_client_finder_app/screens/property/add_land_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Property Client Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        // initialRoute: "/login",
        home: LoginScreen(),
        builder: EasyLoading.init(),
        getPages: appPages);
  }
}
