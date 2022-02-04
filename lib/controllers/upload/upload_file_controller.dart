import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class ImageUploadController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  // List<Widget> imageWidgets = _images.map((c) => new Image.file(c)).toList();
  // RxList imageFileList = [].obs;
  // var imageFileList = [].obs;
  void showDialog(BuildContext context) async {
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
                openGallery(context);
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

  void openGallery(BuildContext context) async {
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
      if (selectedImages!.length == 1) {
        File? croppedFile = await ImageCropper.cropImage(
            sourcePath: selectedImages[0].path,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            androidUiSettings: const AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: const IOSUiSettings(
              title: 'Cropper',
            ));
        // final File? file = File(croppedImages[0].path);
        imageFileList!.add(XFile(croppedFile!.path));
      }
      if (selectedImages.length > 1) {
        imageFileList!.addAll(selectedImages);
      }
      // Get.back();
      Navigator.pop(context);
      update();
      // print("Image List Length:" + imageFileList!.length.toString());
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }

    // setState((){});
  }

  // void clearImages() {
  //   imageFileList = [];
  //   update();
  // }
}
