import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:property_client_finder_app/controllers/auth/change_password_controller.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final ChangePassword changePassword = Get.put(ChangePassword());
    return Obx(() => ModalProgressHUD(
          inAsyncCall: changePassword.isLoading.value,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: height * 0.15,
                      width: width * 0.3,
                      margin: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/userImage.png")
                              // image: AssetImage("assets/images/home.jpg")

                              )),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: const EdgeInsets.all(15),
                    child: Form(
                        key: changePassword.passwordFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                // keyboardType: TextInputType.number,
                                obscureText:
                                    changePassword.isOldInvisible.value,
                                controller:
                                    changePassword.oldPasswordController,
                                onSaved: (value) {
                                  changePassword.oldPassword = value!.trim();
                                },
                                validator: (value) {
                                  return changePassword
                                      .validateCurrentPassword(value);
                                },
                                decoration: InputDecoration(
                                    labelText: "Current Password",
                                    suffixIcon: IconButton(
                                      icon: changePassword.isOldInvisible.value
                                          ? const Icon(Icons.remove_red_eye)
                                          : const Icon(Icons.visibility_off),
                                      onPressed:
                                          changePassword.toggleOldPassword,
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.password_rounded),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                // keyboardType: TextInputType.number,
                                obscureText:
                                    changePassword.isNewInvisible.value,

                                // inputFormatters: [FilteringTextInputFormastter.digitsOnly],
                                controller:
                                    changePassword.newPasswordController,
                                onSaved: (value) {
                                  changePassword.newPassword = value!.trim();
                                },
                                validator: (value) {
                                  return changePassword
                                      .validateNewPassword(value);
                                },
                                decoration: InputDecoration(
                                    labelText: "New Password",
                                    suffixIcon: IconButton(
                                      icon: changePassword.isNewInvisible.value
                                          ? const Icon(Icons.remove_red_eye)
                                          : const Icon(Icons.visibility_off),
                                      onPressed:
                                          changePassword.toggleNewPassword,
                                    ),
                                    prefixIcon: const Icon(Icons.new_label),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  changePassword.chanePassword(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: const Center(
                                    child: Text('Update Password',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red[700],
                                    borderRadius: BorderRadius.circular(10),
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
