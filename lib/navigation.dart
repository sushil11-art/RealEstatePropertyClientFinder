// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/middleware/auth_middleware.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
import 'package:property_client_finder_app/screens/auth/register_screen.dart';
import 'package:property_client_finder_app/screens/client/client_details_screen.dart';
import 'package:property_client_finder_app/screens/client/clients_screen.dart';
import 'package:property_client_finder_app/screens/client/add_client_screen.dart';
import 'package:property_client_finder_app/screens/client/matching_clients_screen.dart';

import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:property_client_finder_app/screens/map/map_screen.dart';
import 'package:property_client_finder_app/screens/property/add_home_screen.dart';
import 'package:property_client_finder_app/screens/property/add_land_screen.dart';
import 'package:property_client_finder_app/screens/property/matching_properties_screen.dart';
import 'package:property_client_finder_app/screens/property/property_details_screen.dart';
import 'package:property_client_finder_app/screens/tabs/tabs_screen.dart';

final appPages = [
  GetPage(
      name: Routes.tabScreen,
      page: () => TabScreen(),
      middlewares: [AuthGuard()]),
  GetPage(
    name: Routes.home,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: Routes.login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: Routes.register,
    page: () => RegisterScreen(),
  ),
  GetPage(
      name: Routes.clients,
      page: () => ClientScreen(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.addLand, page: () => AddLand(), middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.addHome, page: () => AddHome(), middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.addClient,
      page: () => AddClient(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.propertyDetails,
      page: () => PropertyDetails(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.clientDetails,
      page: () => ClientDetails(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.matchingClients,
      page: () => MatchingClients(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.matchingProperties,
      page: () => MatchingProperty(),
      middlewares: [AuthGuard()]),
  GetPage(
      name: Routes.picklocation,
      page: () => MapScreen(),
      middlewares: [AuthGuard()])
];
