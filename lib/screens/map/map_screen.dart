import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:get/get.dart';

class MapScreen extends StatelessWidget {
  // const MapScreen({Key? key}) : super(key: key);
  final MapController mapController = Get.put(MapController());
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller =
        await mapController.controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(mapController.kGooglePlex));
  }

  Future<void> _goToPropertyLocation() async {
    final GoogleMapController controller =
        await mapController.controller.future;
    final CameraPosition propertyLocation = CameraPosition(
      target: LatLng(mapController.latitude, mapController.longitude),
      zoom: 14.4746,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(propertyLocation));
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Pick a location'),
        actions: [
          // if (mapController.location != null)
          GetBuilder<MapController>(
              init: MapController(),
              builder: (context) {
                if (mapController.location != null) {
                  return TextButton.icon(
                      onPressed: _goToPropertyLocation,
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      label: const Text(
                        "Current",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ));
                }
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_off,
                    color: Colors.blueAccent,
                  ),
                );
              })
        ],
      ),
      body: GetBuilder<MapController>(
          init: MapController(),
          builder: (context) {
            return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: mapController.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  mapController.controller.complete(controller);
                },
                onLongPress: mapController.selectLocation,
                markers: {
                  if (mapController.location != null) mapController.location!
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentLocation,
        // onPressed: mapController.googleMapController.future
        //     .animateCamera(cameraUpdate),
        child: const Icon(Icons.center_focus_strong),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
