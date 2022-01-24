import 'package:flutter/material.dart';
import 'package:property_client_finder_app/controllers/auth/register_controller.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.put(RegisterController());
    return Obx(() => Container(
          margin: const EdgeInsets.all(8),
          child: Form(
              key: registerController.registerFormKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: registerController.emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) {
                        registerController.email = value!.trim();
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) {
                        registerController.username = value!.trim();
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) {
                        registerController.password = value!.trim();
                      },
                      validator: (value) {
                        return registerController.validatePassword(value);
                      },
                      obscureText: registerController.isPasswordInvisible.value,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: registerController.togglePassword,
                            icon: registerController.isPasswordInvisible.value
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.visibility_off),
                          ),
                          prefixIcon: const Icon(Icons.password),
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 2))),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
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
                  registerController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : Padding(
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
        ));
  }
}
