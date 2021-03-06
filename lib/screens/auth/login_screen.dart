import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/auth/login_controller.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/controllers/auth/login_controller.dart';

import 'package:property_client_finder_app/screens/auth/register_screen.dart';
import 'package:property_client_finder_app/widgets/auth/auth_image.dart';
import 'package:property_client_finder_app/widgets/auth/auth_title.dart';
import 'package:property_client_finder_app/widgets/auth/login_form.dart';
// import 'package:property_client_finder_app/widgets/loading/loading.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  // String token;

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('The System Back Button is Deactivated')));
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() =>
            // ModalProgressHUD(
            //     inAsyncCall: loginController.isLoading.value,
            //     child:

            AbsorbPointer(
              absorbing: loginController.isLoading.value,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthImage(image: "assets/images/home.jpg"),
                        AuthTitle(title: "Login To Continue"),
                        LoginForm(),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Need an account?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // Navigator.of(context).
                                        Get.off(RegisterScreen());
                                        // Get.offAndToNamed(Routes.register);
                                      },
                                      child: const Text('Register',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.white))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
