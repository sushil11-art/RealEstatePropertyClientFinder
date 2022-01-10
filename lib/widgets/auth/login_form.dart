import 'package:flutter/material.dart';
import 'package:property_client_finder_app/controllers/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put((LoginController()));

    return Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: loginController.loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: loginController.emailController,
                  onSaved: (value) {
                    loginController.email = value!;
                  },
                  validator: (value) {
                    return loginController.validateEmail(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: loginController.passwordController,
                  onSaved: (value) {
                    loginController.password = value!;
                  },
                  validator: (value) {
                    return loginController.validatePassword(value);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      prefixIcon: const Icon(Icons.password),
                      labelText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password ?',
                              style: TextStyle(color: Colors.black)),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white))
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    loginController.loginBroker(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: const Center(
                      child: Text('Login',
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
    );
  }
}