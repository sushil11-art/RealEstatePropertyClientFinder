// integrate google map flutter
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapController extends GetxController {
  Completer<GoogleMapController> controller = Completer();

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(27.6588, 85.3247),
    zoom: 14.4746,
  );

  Marker? location;

  var latitude;
  var longitude;

  void selectLocation(LatLng pos) async {
    // print(latitude);
    // print(longitude);

    // print(pos.latitude);

    // if (location != null) location = null;
    // Origin is not set OR Origin/Destination are both set
    // Set origin
    // setState(() {
    location = Marker(
      markerId: const MarkerId('property'),
      infoWindow: const InfoWindow(title: 'Property location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: pos,
    );

    latitude = pos.latitude;
    longitude = pos.longitude;
    // print(latitude);

    // print(longitude);
    update();
    // Reset destination
    // _destination = null;

    // Reset info
    // _info = null;
    // });
  }
  // late GoogleMapController googleMapController;

  @override
  void onClose() {
    // TODO: implement onClose

    // controller.dispose();
    super.onClose();
  }
}
