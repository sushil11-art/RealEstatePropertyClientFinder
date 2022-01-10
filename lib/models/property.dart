// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:json_annotation/json_annotation.dart';
import 'package:property_client_finder_app/models/broker.dart';
import 'package:property_client_finder_app/models/location.dart';

part 'property.g.dart';

@JsonSerializable(explicitToJson: true)
class Property {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'sellStatus')
  bool sellStatus;
  @JsonKey(name: 'images')
  String images;
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @JsonKey(name: 'landId')
  var landId;
  @JsonKey(name: 'homeId')
  var homeId;
  @JsonKey(name: 'brokerId')
  int brokerId;
  @JsonKey(name: 'locationId')
  int locationId;
  @JsonKey(name: 'land')
  var land;
  @JsonKey(name: 'broker')
  Broker broker;
  @JsonKey(name: 'home')
  var home;
  @JsonKey(name: 'location')
  Location location;

  Property(
      {required this.id,
      required this.sellStatus,
      required this.images,
      required this.createdAt,
      required this.updatedAt,
      required this.landId,
      required this.homeId,
      required this.brokerId,
      required this.locationId,
      required this.land,
      required this.broker,
      required this.home,
      required this.location});

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

// class Food {
//   var name;
//   var price;
//   var maxOffer;
//   var minOrder;
//   Food({})
// }
