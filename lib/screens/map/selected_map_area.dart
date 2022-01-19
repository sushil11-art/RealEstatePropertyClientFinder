import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:get/get.dart';

class SelectedMapArea extends StatelessWidget {
  // cosnst SelectedMapArea({Key? key}) : super(key: key);
  // Completer<GoogleMapController> _controller = Completer();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(27.6588, 85.3247),
    zoom: 14.4746,
  );
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.2,
      child: GetBuilder<MapController>(
          init: MapController(),
          builder: (context) {
            return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(mapController.latitude, mapController.longitude),
                    zoom: 14.4746),
                onMapCreated: (GoogleMapController controller) {
                  if (!(mapController.controller.isCompleted)) {
                    mapController.controller.complete(controller);
                    // mapController.controller =
                    //     controller as Completer<GoogleMapController>;
                  } else {
                    //other calling, later is true,
                    //don't call again completer()
                  }
                },
                markers: {
                  if (mapController.location != null) mapController.location!
                });
          }),
    );
  }
}
