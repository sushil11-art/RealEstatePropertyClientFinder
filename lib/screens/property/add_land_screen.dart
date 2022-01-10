import 'package:flutter/material.dart';
// import 'package:property_client_finder_app/widgets/map/google_maps.dart';
import 'package:property_client_finder_app/widgets/property/land_form.dart';
import 'package:property_client_finder_app/widgets/upload/image_upload.dart';

class AddLand extends StatelessWidget {
  const AddLand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          title: const Text(
            "Add Land",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.redAccent),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ImageUpload(), LandForm()],
          ),
        ),
      ),
    );
  }
}
