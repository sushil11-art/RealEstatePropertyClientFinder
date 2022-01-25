import 'package:flutter/material.dart';
// import 'package:property_client_finder_app/controllers/client/client_controller.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/helpers/create_image_url.dart';
import 'package:get/get.dart';
import 'package:blurry/blurry.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:blurry/resources/arrays.dart';
// import 'package:property_client_finder_app/routes.dart';

class MatchingPropertyItem extends StatelessWidget {
  // Set<dynamic>? property;
  int index;
  var property;
  MatchingPropertyItem({required this.index, required this.property});

  final imageUrl = CreateImageUrl();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PropertyListController propertyListController =
        Get.put(PropertyListController());
    // final ClientController clientController = Get.put(ClientController());
    var price;
    var title;
    var address = property["location"]["district"] +
        "," +
        property["location"]["municipality"] +
        "-" +
        property["location"]["ward"].toString();

    if (property["home"] == null) {
      price = property["land"]["price"];
      title = "Land for Sale";
    } else {
      price = property["home"]["price"];
      title = "Home for Sale";
    }
    // print(price);
    // print(property.images);
    List<String> images = imageUrl.generateImageUrl(property["images"]);
    // print(images[0]);

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: width * 0.35,
                  height: height * 0.19,
                  margin: const EdgeInsets.all(14),
                  child: Image.network(
                    images[0],
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/home.jpg"),
                          // image: AssetImage("assets/images/home.jpg")
                        )),
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: const Text(
                          'Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                      // return FancyShimmerImage(
                      //     shimmerBaseColor: Colors.grey,
                      //     shimmerHighlightColor: Colors.redAccent,
                      //     shimmerBackColor: Colors.blue,
                      //     imageUrl:
                      //         'https://image.shutterstock.com/image-photo/polarization-pearl-sequins-shiny-glitter-260nw-1095200171.jpg');
                      // return Center(
                      //   child: CircularProgressIndicator(
                      //     value: loadingProgress.expectedTotalBytes != null
                      //         ? loadingProgress.cumulativeBytesLoaded /
                      //             loadingProgress.expectedTotalBytes!
                      //         : null,
                      //   ),
                      // );
                    },
                  )
                  //  CachedNetworkImage(
                  //   imageUrl: images[0],
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover, image: NetworkImage(images[0]),
                  //       // image: AssetImage("assets/images/home.jpg")
                  //     )),
                  ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 14, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        address,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Nrs.${price.toString()}',
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                propertyListController
                                    .propertyDetails(property["id"]);
                                // Get.offAndToNamed(Routes.propertyDetails);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              label: const Text(
                                'Details',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
          // Container(
          //   margin: const EdgeInsets.only(left: 14, right: 14),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       TextButton.icon(
          //           icon: const Icon(
          //             Icons.person,
          //             color: Colors.pink,
          //           ),
          //           onPressed: () {
          //             // Get.toNamed(Routes.addLand);
          //             propertyListController
          //                 .matchingClientsForProperty(property.id);
          //           },
          //           style: TextButton.styleFrom(
          //             // primary: Colors.pink[600],
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(25),
          //             ),
          //           ),
          //           label: const Text(
          //             'Clients',
          //             style: TextStyle(color: Colors.black),
          //           )),
          //       TextButton.icon(
          //           icon: const Icon(
          //             Icons.edit,
          //             color: Colors.blue,
          //           ),
          //           onPressed: () {
          //             // Get.toNamed(Routes.addLand);
          //           },
          //           style: TextButton.styleFrom(
          //             // primary: Colors.pink,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(25),
          //             ),
          //           ),
          //           label: const Text(
          //             'Edit',
          //             style: TextStyle(color: Colors.black),
          //           )),
          //       TextButton.icon(
          //           icon: const Icon(
          //             Icons.delete,
          //             color: Colors.redAccent,
          //           ),
          //           onPressed: () {
          //             Blurry(
          //                 icon: Icons.delete,
          //                 themeColor: Colors.pink,
          //                 title: 'Delete Property',
          //                 description: 'Remove your property?',
          //                 confirmButtonText: 'Confirm',
          //                 onConfirmButtonPressed: () {
          //                   propertyListController.deleteProperty(
          //                       property.id, property.landId, property.homeId);
          //                 }).show(context);

          //             // Get.toNamed(Routes.addLand);s
          //           },
          //           style: TextButton.styleFrom(
          //             // primary: Colors.pink[600],
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(25),
          //             ),
          //           ),
          //           label: const Text(
          //             'Delete',
          //             style: TextStyle(color: Colors.black),
          //           )),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
