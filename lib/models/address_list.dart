import 'package:json_annotation/json_annotation.dart';
import 'package:property_client_finder_app/models/address.dart';

// import 'package:property_client_finder_app/models/property.dart';

// part 'property_list.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressList {
  // @JsonKey(name: 'home')
  final List<Address> address;

  AddressList({
    required this.address,
  });
  factory AddressList.fromJson(List<dynamic> parsedJson) {
    List<Address> address = [];
    address = parsedJson.map((i) => Address.fromJson(i)).toList();
    return AddressList(address: address);
  }
}
