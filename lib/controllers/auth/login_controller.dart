import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:property_client_finder_app/routes.dart';
// import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:property_client_finder_app/services/auth/login_services.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    // ProgressDialog pr;
    // pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    // ProgressDialog pd = ProgressDialog(context: context);

    // pr.style(
    //   message: 'Loading',
    //   borderRadius: 10.0,
    //   backgroundColor: Colors.white,
    //   progressWidget: const CircularProgressIndicator(),
    //   elevation: 10.0,
    //   insetAnimCurve: Curves.easeInOut,
    //   progressTextStyle: const TextStyle(
    //       color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    //   messageTextStyle: const TextStyle(
    //       color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    // );

    var valid = loginFormKey.currentState!.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (!valid) {
      return;
    }
    loginFormKey.currentState!.save();
    // await pr.show();
    EasyLoading.show(status: 'Loading');

    var response = await LoginServices.loginBroker(email, password);
    if (response.statusCode == 200) {
      var results = json.decode(response.body);
      // print(results["token"]);
      await box.write('token', results["token"]);

      if (!(box.read('token').isEmpty)) {
        isAuthenticated.value = true;
        Get.offAndToNamed(Routes.home);
      }
    }
    if ((response.statusCode == 400) ||
        (response.statusCode == 500) ||
        (response.statusCode == 422)) {
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
    EasyLoading.dismiss();
  }
}
