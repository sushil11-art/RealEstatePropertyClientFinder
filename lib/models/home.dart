// import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable(explicitToJson: true)
class Home {
  int id;
  double price;
  double landArea;
  String roadAccess;
  String waterSupply;
  int kitchens;
  int bathrooms;
  double floors;
  int bedrooms;
  DateTime createdAt;
  DateTime updatedAt;

  Home(
      {required this.id,
      required this.price,
      required this.landArea,
      required this.roadAccess,
      required this.waterSupply,
      required this.kitchens,
      required this.bathrooms,
      required this.floors,
      required this.bedrooms,
      required this.createdAt,
      required this.updatedAt});

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
