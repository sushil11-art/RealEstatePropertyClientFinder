import 'package:flutter/material.dart';
import 'package:property_client_finder_app/controllers/auth/register_controller.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
import 'package:property_client_finder_app/widgets/auth/auth_image.dart';
import 'package:property_client_finder_app/widgets/auth/auth_title.dart';
import 'package:property_client_finder_app/widgets/auth/register_form.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  // const RegisterScreen({Key? key}) : super(key: key);

  final RegisterController registerController = Get.put(RegisterController());
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
          body: Obx(
            () => ModalProgressHUD(
                inAsyncCall: registerController.isLoading.value,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthImage(image: "assets/images/home.jpg"),
                          AuthTitle(title: "Register To Continue"),
                          RegisterForm(),
                          Column(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.off(LoginScreen());
                                          // Get.offAndToNamed(Routes.login);
                                        },
                                        child: const Text('Login',
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
                )),
          )),
    );
  }
}
