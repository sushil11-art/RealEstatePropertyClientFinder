import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';
import 'package:property_client_finder_app/routes.dart';

// import 'package:property_client_finder_app/controllers/auth/change_password_controller.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final ChangePassword changePassword = Get.put(ChangePassword());
    final GetProfile getProfile = Get.put(GetProfile());
    var username;
    var email;
    var properties;
    var clients;
    if (getProfile.profile.value != null) {
      username = getProfile.profile["data"]["broker"]["username"];
      email = getProfile.profile["data"]["broker"]["email"];
      properties = getProfile.profile["data"]["propertyCount"];
      clients = getProfile.profile["data"]["clientCount"];
    }

    return Obx(() => ModalProgressHUD(
          inAsyncCall: getProfile.isLoading.value,
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Username:-$username',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Email:-$email',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.home,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Total Properties:-${properties.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.people,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Total Clients:-${clients.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.changePassword);
                    },
                    child: Card(
                      margin: const EdgeInsets.all(12),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.settings,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Change Password',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 170),
                            const Icon(
                              Icons.forward,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
