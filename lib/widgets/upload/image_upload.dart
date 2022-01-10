import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:property_client_finder_app/controllers/upload/upload_file_controller.dart';
import 'dart:io';

// import 'package:property_client_finder_app/controllers/upload/upload_controller.dart';

// import 'package:property_client_finder_app/widgets/upload/image_preview.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ImageUploadController imageUploadController =
        Get.put(ImageUploadController());

    return Container(
      margin: const EdgeInsets.only(top: 45),
      child: Column(
        children: [
          Center(
            child: ElevatedButton.icon(
                onPressed: imageUploadController.showDialog,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Upload pictures')),
          ),
          // if (imageUploadController.imageFileList!.isNotEmpty)
          GetBuilder<ImageUploadController>(
              init: ImageUploadController(),
              builder: (context) {
                if (imageUploadController.imageFileList!.isNotEmpty) {
                  return Container(
                      margin: const EdgeInsets.all(8),
                      height: size.height * 0.2,
                      width: double.infinity,
                      child: GridView.builder(
                          itemCount:
                              imageUploadController.imageFileList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Image.file(File(imageUploadController
                                  .imageFileList![index].path)),
                            );
                          })

                      // child: GetBuilder<ImageUploadController>(
                      //     init: ImageUploadController(),
                      //     builder: (context) {
                      //       return ListView.builder(
                      //           scrollDirection: Axis.horizontal,
                      //           itemCount: imageUploadController.imageFileList!.length,
                      //           itemBuilder: (context, index) => Container(
                      //                 margin: const EdgeInsets.all(8),
                      //                 height: size.height * 0.2,
                      //                 width: size.width * 0.4,
                      //                 decoration: const BoxDecoration(
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: Image.file(File(imageUploadController
                      //                             .imageFileList![index].path)))),
                      //               ));
                      //     }),
                      );
                } else {
                  return Container();
                }
              })
          // Flexible(child: Imagepreview())
        ],
      ),
    );
  }
}
