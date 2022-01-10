import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  // List<Widget> imageWidgets = _images.map((c) => new Image.file(c)).toList();
  // RxList imageFileList = [].obs;
  // var imageFileList = [].obs;
  void showDialog() async {
    await Get.dialog(AlertDialog(
      title: const Text('Choose an option'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            const Divider(
              height: 1,
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                // _picker.pickImage
                openGallery();
              },
              title: const Text("Gallery"),
              leading: const Icon(
                Icons.account_box,
                color: Colors.blue,
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blue,
            ),
            // ListTile(
            //   onTap: () {
            //     // _openCamera(context);
            //   },
            //   title: const Text("Camera"),
            //   leading: const Icon(
            //     Icons.camera,
            //     color: Colors.blue,
            //   ),
            // ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Get.back(), // Close the dialog
            child: const Text('Close'))
      ],
    ));
  }

  void openGallery() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    try {
      if (imageFileList!.length > 10) {
        imageFileList = [];
        Get.back();
        Get.snackbar(
            'Error occured', "You can upload at least 1 and maximum 10 images",
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.only(top: 70),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        return;
      }
      if (selectedImages!.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      }
      Get.back();
      update();
      // print("Image List Length:" + imageFileList!.length.toString());
    } catch (e) {}

    // setState((){});
  }

  // void clearImages() {
  //   imageFileList = [];
  //   update();
  // }
}
