import 'package:flutter/material.dart';
import 'package:property_client_finder_app/screens/auth/login_screen.dart';
import 'package:property_client_finder_app/widgets/auth/auth_image.dart';
import 'package:property_client_finder_app/widgets/auth/auth_title.dart';
import 'package:property_client_finder_app/widgets/auth/register_form.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ));
  }
}