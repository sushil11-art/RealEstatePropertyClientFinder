import 'package:flutter/material.dart';
// import 'package:property_client_finder_app/controllers/tabs/tab_controller.dart';
import 'package:property_client_finder_app/screens/client/clients_screen.dart';
import 'package:property_client_finder_app/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:property_client_finder_app/screens/settings/setting_screen.dart';

class TabScreen extends StatefulWidget {
  // const TabScreen({Key? key}) : super(key: key);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
      'title': 'Real Estate',
    },
    {'page': Settings(), 'title': 'Settings'},
    {
      'page': ClientScreen(),
      'title': 'Clients',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.red),
        ),
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
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
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        // onTap: controller.changeTabIndex,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clients',
          ),
        ],
      ),
    );
  }
}
