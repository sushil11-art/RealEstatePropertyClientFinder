// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/client/client_details_screen.dart';
import 'package:property_client_finder_app/screens/client/clients_screen.dart';
import 'package:property_client_finder_app/screens/client/add_client_screen.dart';
import 'package:property_client_finder_app/screens/client/edit_client_screen.dart';
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
  ),
  GetPage(
    name: Routes.home,
    page: () => HomeScreen(),
  ),
  GetPage(name: Routes.clients, page: () => ClientScreen()),
  GetPage(
    name: Routes.addLand,
    page: () => AddLand(),
  ),
  GetPage(
    name: Routes.addHome,
    page: () => AddHome(),
  ),
  GetPage(name: Routes.addClient, page: () => AddClient()),
  GetPage(name: Routes.editClient, page: () => EditClientScreen()),
  GetPage(
    name: Routes.propertyDetails,
    page: () => PropertyDetails(),
  ),
  GetPage(name: Routes.clientDetails, page: () => ClientDetails()),
  GetPage(name: Routes.matchingClients, page: () => MatchingClients()),
  GetPage(name: Routes.matchingProperties, page: () => MatchingProperty()),
  GetPage(name: Routes.picklocation, page: () => MapScreen())
];
