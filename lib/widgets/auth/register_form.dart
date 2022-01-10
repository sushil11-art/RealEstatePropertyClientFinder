import 'package:flutter/material.dart';
import 'package:property_client_finder_app/controllers/auth/register_controller.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());
    return Container(
      margin: const EdgeInsets.all(8),
      child: Form(
          key: registerController.registerFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: registerController.emailController,
                  onSaved: (value) {
                    registerController.email = value!;
                  },
                  validator: (value) {
                    return registerController.validateEmail(value);
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
                  controller: registerController.usernameController,
                  onSaved: (value) {
                    registerController.username = value!;
                  },
                  validator: (value) {
                    return registerController.validateUsername(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Username",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: registerController.passwordController,
                  onSaved: (value) {
                    registerController.password = value!;
                  },
                  validator: (value) {
                    return registerController.validatePassword(value);
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
                    registerController.registerBroker(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: const Center(
                      child: Text('Register',
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
