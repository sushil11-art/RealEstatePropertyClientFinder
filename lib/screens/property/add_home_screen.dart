import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/property/home_controller.dart';
import 'package:property_client_finder_app/widgets/property/home_form.dart';
import 'package:property_client_finder_app/widgets/upload/image_upload.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddHome extends StatelessWidget {
  // const AddHome({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: homeController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
                elevation: 10,
                title: homeController.editMode.value
                    ? const Text("Edit Home Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20))
                    : const Text(
                        "Add Home Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
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
          ),
        ));
  }
}
