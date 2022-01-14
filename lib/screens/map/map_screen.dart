import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:property_client_finder_app/controllers/map/map_controller.dart';
import 'package:get/get.dart';

class MapScreen extends StatelessWidget {
  // const MapScreen({Key? key}) : super(key: key);
  late GoogleMapController animateController;

  void dispose() {
    mapController.dispose();
  }

  final MapController mapController = Get.put(MapController());
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller =
        await mapController.controller.future;
    await animateController.animateCamera(
        CameraUpdate.newCameraPosition(mapController.kGooglePlex));
  }

  Future<void> _goToPropertyLocation() async {
    // final GoogleMapController controller =
    //     await mapController.controller.future;

    // print("mapcontroller");
    // print(mapController);
    // print("latitude");
    // print(mapController.latitude);
    // print("longitude");
    // print(mapController.longitude);
    // print("controller haii");
    // print(controller);
    LatLng latLng = LatLng(mapController.latitude, mapController.longitude);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 17.4);
    // final CameraPosition propertyLocation = CameraPosition(
    //   target: LatLng(mapController.latitude, mapController.longitude),
    //   zoom: 14.4746,
    // );
    await animateController.animateCamera(cameraUpdate);
    // await controller
    //     .animateCamera(CameraUpdate.newCameraPosition(propertyLocation));
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
                  animateController = controller;
                  if (!(mapController.controller.isCompleted)) {
                    mapController.controller.complete(controller);
                    // mapController.controller =
                    //     controller as Completer<GoogleMapController>;
                  } else {
                    //other calling, later is true,
                    //don't call again completer()
                  }
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
