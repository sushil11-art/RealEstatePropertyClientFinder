import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:property_client_finder_app/services/auth/login_services.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final box = GetStorage();

  var email = "";
  var password = "";
  final isAuthenticated = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (!EmailValidator.validate(value!)) {
      return "Please enter email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "Password must be at least 8 character long";
    }
    return null;
  }

  void loginBroker(BuildContext context) async {
    var valid = loginFormKey.currentState!.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!valid) {
      return;
    }
    loginFormKey.currentState!.save();
    // final progress = ProgressHUD.of(context);
    // progress?.show();

    //   AlertDialog alert = AlertDialog(
    //         content: Row(
    //           children: [
    //             CircularProgressIndicator();
    //           ],
    //         ),
    //       );
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );

    // await pr.show();
    // EasyLoading.show(status: 'Loading');
    // Get.dialog(AlertDialog(
    //   // title: const Text('Registration failed'),
    //   content: Row(
    //     children: const [
    //       Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     ],
    //   ),

    //   // actions: [
    //   //   TextButton(
    //   //       onPressed: () => Get.back(), // Close the dialog
    //   //       child: const Text('Close'))
    //   // ],
    // ));
    isLoading.value = true;

    var response = await LoginServices.loginBroker(email, password);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      isLoading.value = false;
      // progress.dismiss();
      // progress?.dismiss();

      var results = json.decode(response.body);
      // print(results["token"]);
      await box.write('token', results["token"]);

      if (!(box.read('token').isEmpty)) {
        isAuthenticated.value = true;
        Get.offAndToNamed(Routes.tabScreen);
      }
    }
    if ((response.statusCode == 400) ||
        (response.statusCode == 500) ||
        (response.statusCode == 422)) {
      isLoading.value = false;
      // progress?.dismiss();

      await Get.dialog(AlertDialog(
        title: const Text('Login failed'),
        content: const Text('Invalid email or password,please try again'),
        actions: [
          TextButton(
              onPressed: () => Get.back(), // Close the dialog
              child: const Text('Close'))
        ],
      ));
    }
    // await pr.hide();
    // EasyLoading.dismiss();
    // Get.back();
  }
}
