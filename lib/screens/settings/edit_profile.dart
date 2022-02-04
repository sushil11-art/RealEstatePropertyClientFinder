import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:property_client_finder_app/controllers/auth/editprofile_controller.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController profileController =
      Get.put(EditProfileController());

  File? file;
  // PickedFile? imageFile = null;
  ImagePicker _picker = ImagePicker();

  Future<void> _showChoiceDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
        builder: (BuildContext context) {
          return Wrap(children: [
            ListTile(
              onTap: () {
                _openGallery(context);
              },
              leading: const Icon(
                Icons.folder,
                color: Colors.green,
              ),
              title: const Text('Gallery'),
            ),
            ListTile(
              onTap: () {
                _openCamera(context);
              },
              leading: const Icon(Icons.camera, color: Colors.red),
              title: const Text('Camera'),
            ),
          ]);
        });
  }

  void _openGallery(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      // print(image!.path);
      if (image!.path != null) {
        File? croppedFile = await ImageCropper.cropImage(
            sourcePath: image.path,
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
        if (croppedFile != null) {
          file = croppedFile;
          setState(() {
            file = File(croppedFile.path);
            // state = AppState.cropped;
          });
          profileController.isProfileEditMode.value = false;
        }
      }

      Navigator.pop(context);
    } catch (e) {
      print(e);
      // Navigator.pop(context);
    }
  }

  void _openCamera(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      // print(image!.path);
      if (image!.path != null) {
        File? croppedFile = await ImageCropper.cropImage(
            sourcePath: image.path,
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
        if (croppedFile != null) {
          file = croppedFile;
          setState(() {
            file = File(croppedFile.path);
            // state = AppState.cropped;
          });
          profileController.isProfileEditMode.value = false;
        }
      }

      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() => AbsorbPointer(
          absorbing: profileController.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
                elevation: 10,
                title: const Text(
                  "Update Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                backgroundColor: Colors.redAccent),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(15),
                    child: Form(
                        key: profileController.editProfileFormKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  if (profileController.profileImage != null &&
                                      profileController.isProfileEditMode.value)
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          profileController.profileImage),
                                      onBackgroundImageError: (_, a) {
                                        // getProfile.isProfileImageError.value = true;
                                      },
                                    ),
                                  if (!profileController
                                      .isProfileEditMode.value)
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: file != null
                                          ? FileImage(file!)
                                          : null,
                                    ),
                                  TextButton.icon(
                                      onPressed: () {
                                        if (profileController.isLoading.value) {
                                        } else {
                                          _showChoiceDialog(context);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        'Upload a picture',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                // keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller:
                                    profileController.usernameController,
                                onSaved: (value) {
                                  profileController.username = value!.trim();
                                },
                                validator: (value) {
                                  return profileController
                                      .validateUsername(value);
                                },
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    prefixIcon: const Icon(Icons.person),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  if (file != null) {
                                    profileController.editProfileDetails(
                                        file, context);
                                    // profileController.getProfileDetails();
                                  } else {
                                    profileController.editProfileDetails(
                                        null, context);
                                  }
                                  // changePassword.chanePassword(context);
                                },
                                child: profileController.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.red,
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 60,
                                        child: const Center(
                                          child: Text('Update Profile',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red[700],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
