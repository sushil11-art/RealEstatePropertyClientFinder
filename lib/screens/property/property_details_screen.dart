import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/controllers/property/property_list_controller.dart';
import 'package:property_client_finder_app/helpers/create_image_url.dart';
import 'package:property_client_finder_app/routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class PropertyDetails extends StatelessWidget {
  final imageUrl = CreateImageUrl();
  final PropertyListController propertyController =
      Get.put(PropertyListController());

  @override
  Widget build(BuildContext context) {
    var price;
    var landArea;
    var roadAccess;
    var waterSupply;
    var title;
    var province;
    var district;
    var municipality;
    var ward;
    var street;
    var kitchens;
    var bathrooms;
    var bedrooms;
    var floors;
    province = propertyController.propertyDescription["location"]["province"];
    district = propertyController.propertyDescription["location"]["district"];
    municipality =
        propertyController.propertyDescription["location"]["municipality"];
    ward = propertyController.propertyDescription["location"]["ward"];
    landArea = propertyController.propertyDescription["area"];

    street = propertyController.propertyDescription["location"]["street"];

    if (propertyController.propertyDescription["home"] == null) {
      var f = NumberFormat("##,##,###.0#", "en_US");
      // price = f.format(property.land["price"]);
      price = f.format(propertyController.propertyDescription["land"]["price"]);
      roadAccess = propertyController.propertyDescription["land"]["roadAccess"];
      waterSupply =
          propertyController.propertyDescription["land"]["waterSupply"];
      title = "Land";
    } else {
      var f = NumberFormat("##,##,###.0#", "en_US");
      // price = f.format(property.land["price"]);
      price = f.format(propertyController.propertyDescription["home"]["price"]);
      // price = propertyController.propertyDescription["home"]["price"];
      roadAccess = propertyController.propertyDescription["home"]["roadAccess"];
      waterSupply =
          propertyController.propertyDescription["home"]["waterSupply"];
      kitchens = propertyController.propertyDescription["home"]["kitchens"];
      bathrooms = propertyController.propertyDescription["home"]["bathrooms"];
      bedrooms = propertyController.propertyDescription["home"]["bedrooms"];
      floors = propertyController.propertyDescription["home"]["floors"];
      title = "Home";
    }

    List<String> images = imageUrl
        .generateImageUrl(propertyController.propertyDescription["images"]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        //   onPressed: () {
        //     Get.offAndToNamed(Routes.tabScreen);
        //   },
        // ),
        title: const Text(
          'Property Details',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            // const SizedBox(height: 15),
            CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8, left: 5, right: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    child: Image.network(
                      images[itemIndex],
                      fit: BoxFit.cover,
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
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                )),
            Container(
              margin: const EdgeInsets.only(top: 14, left: 14, right: 14),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 253, 208, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 10, // soften the shadow
                      // spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        0, // Move to right 10  horizontally
                        10, // Move to bottom 10 Vertically
                      ),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title.toString(),
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      Text('Nrs.${price.toString()}',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.landscape_rounded,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Land Area:-',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text('$landArea',
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_bus_rounded,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Road Access:-',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(roadAccess.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.water_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Water Supply:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(waterSupply.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.accessibility,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Province:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(province.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_transit_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('District:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(district.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.multiline_chart_outlined,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Municipality:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(municipality.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.water_damage,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Ward:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                // color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(ward.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.streetview,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Street:-',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                // color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(street.toString(),
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                  if (bedrooms != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bedroom_baby_sharp,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Bedrooms:-',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  // color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(bedrooms.toString(),
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                  if (kitchens != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.kitchen,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Kitchens:-',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  // color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(kitchens.toString(),
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                  if (bathrooms != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bathroom,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Bathrooms:-',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  // color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(street.toString(),
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                  if (floors != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.folder,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Floors:-',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  // color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(floors.toString(),
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
