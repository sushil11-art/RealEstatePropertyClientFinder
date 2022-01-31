import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:property_client_finder_app/config/show_snackbar.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
                // Navigator.pop(context);
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
                // propertyListController.deleteProperty(
                //     property.id,
                //     property.landId,
                //     property.homeId);
                // Navigator.pop(context);
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
          source: ImageSource.gallery, maxWidth: 150, imageQuality: 50);
      setState(() {
        file = File(image!.path);
      });
      // widget.imagePickFn(file!);

      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void _openCamera(BuildContext context) async {
    try {
      final XFile? image = await _picker.pickImage(
          source: ImageSource.camera, maxWidth: 150, imageQuality: 50);
      setState(() {
        file = File(image!.path);
      });
      // widget.imagePickFn(file!);

      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final GetProfile profileController = Get.put(GetProfile());
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
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    backgroundImage:
                                        file != null ? FileImage(file!) : null,
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        _showChoiceDialog(context);
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
                                  } else {
                                    InvalidToken().showImageSnackBar();
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
