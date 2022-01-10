import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class AuthImage extends StatelessWidget {
  final String image;
  AuthImage({required this.image});
  // const AuthImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image)))),
    );
  }
}
