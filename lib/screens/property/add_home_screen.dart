import 'package:flutter/material.dart';
import 'package:property_client_finder_app/widgets/property/home_form.dart';
import 'package:property_client_finder_app/widgets/upload/image_upload.dart';

class AddHome extends StatelessWidget {
  const AddHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          title: const Text(
            "Add Home",
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
            children: [ImageUpload(), HomeForm()],
          ),
        ),
      ),
    );
  }
}