import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  int id;
  int province;
  String district;
  String municipality;
  int ward;
  String street;
  double latitude;
  double longitude;
  DateTime createdAt;
  DateTime updatedAt;

  Location(
      {required this.id,
      required this.province,
      required this.district,
      required this.municipality,
      required this.ward,
      required this.street,
      required this.latitude,
      required this.longitude,
      required this.createdAt,
      required this.updatedAt});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
