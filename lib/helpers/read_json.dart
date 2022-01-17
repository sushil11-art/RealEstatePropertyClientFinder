import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:property_client_finder_app/models/address_list.dart';

class AddressJson {
  List _items = [];
  // Fetch content from the json file
  Future readJson() async {
    final String response = await rootBundle.loadString('assets/address.json');
    final data = await json.decode(response);
    final listOfData = AddressList.fromJson(data);
    _items = listOfData.address;
    print(_items);
    // return _items;
    // print(listOfData.address[0].nagarpalika);
  }
}
