import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:property_client_finder_app/config/logout_controller.dart';
import 'package:property_client_finder_app/controllers/auth/editprofile_controller.dart';
import 'package:property_client_finder_app/controllers/auth/profile_controller.dart';
import 'package:property_client_finder_app/helpers/create_image_url.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:shimmer/shimmer.dart';

class Settings extends StatelessWidget {
  // const Settings({Key? key}) : super(key: key);
  final createImageUrl = CreateImageUrl();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final ChangePassword changePassword = Get.put(ChangePassword());
    final EditProfileController editProfile = Get.put(EditProfileController());
    final GetProfile getProfile = Get.put(GetProfile());
    var username;
    var email;
    var properties;
    var clients;
    var imageUrl;
    // print(getProfile.profile);
    if (getProfile.profile.value != null) {
      username = getProfile.profile["data"]["broker"]["username"];
      email = getProfile.profile["data"]["broker"]["email"];

      // print(imageUrl);
      properties = getProfile.profile["data"]["propertyCount"];
      clients = getProfile.profile["data"]["clientCount"];
    }
    if (getProfile.profile['data']["broker"]["imageUrl"] != null) {
      imageUrl = createImageUrl
          .profileImage(getProfile.profile["data"]["broker"]["imageUrl"]);
    }

    return Obx(() => ModalProgressHUD(
          inAsyncCall: getProfile.isLoading.value,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: imageUrl != null
                        ? Container(
                            height: height * 0.15,
                            width: width * 0.3,
                            margin: const EdgeInsets.only(top: 40),
                            decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),

                                // image: const DecorationImage(
                                //     fit: BoxFit.cover,
                                //     image: AssetImage("assets/images/userImage.png")
                                //     // image: AssetImage("assets/images/home.jpg")

                                //     )
                                ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                imageUrl,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/userImage.png"),
                                      // image: AssetImage("assets/images/home.jpg")
                                    )),
                                  );
                                },
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    decoration: const BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/userImage.png"),
                                      // image: AssetImage("assets/images/home.jpg")
                                    )),
                                  );
                                  // Shimmer.fromColors(
                                  //   baseColor: Colors.red,
                                  //   highlightColor: Colors.yellow,
                                  //   child: const Text(
                                  //     '',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(
                                  //       fontSize: 40.0,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // );
                                },
                              ),
                            ),
                          )
                        : Container(
                            height: height * 0.15,
                            width: width * 0.3,
                            margin: const EdgeInsets.only(top: 40),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              backgroundImage: const AssetImage(
                                  "assets/images/userImage.png"),
                              onBackgroundImageError: (_, a) {
                                getProfile.isProfileImageError.value = true;
                              },
                            ),
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
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Change Password',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      editProfile.getProfileDetails();
                    },
                    child: Card(
                      margin: const EdgeInsets.all(12),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      LogoutController().logout();
                    },
                    child: Card(
                      margin: const EdgeInsets.all(12),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                'Logout',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
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
