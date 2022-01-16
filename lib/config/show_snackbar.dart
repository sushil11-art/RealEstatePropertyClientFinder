import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvalidToken {
  void showSnackBar() {
    Get.snackbar('Invalid token', "Login session expired",
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        margin: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 30),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING);
  }
}
