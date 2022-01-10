import 'package:json_annotation/json_annotation.dart';
import 'package:property_client_finder_app/models/property.dart';

// part 'property_list.g.dart';

@JsonSerializable(explicitToJson: true)
class PropertyList {
  // @JsonKey(name: 'home')
  final List<Property> properties;

  PropertyList({
    required this.properties,
  });

  // factory PropertyList.fromJson(Map<String, dynamic> json) =>
  //     _$PropertyListFromJson(json);
  factory PropertyList.fromJson(List<dynamic> parsedJson) {
    List<Property> properties = [];
    properties = parsedJson.map((i) => Property.fromJson(i)).toList();
    // print(properties);
    return PropertyList(properties: properties);
  }
  // factory PropertyList.fromJson(List<dynamic> parsedJson) =>
  //     _$PropertyListFromJson(parsedJson);
}
