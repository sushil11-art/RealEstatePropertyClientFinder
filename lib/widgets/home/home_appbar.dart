import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu, color: Colors.red),
      ),
      title: const Text(
        'Real Estate',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 20),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.red,
            ))
      ],
    );
  }
}
