import 'package:json_annotation/json_annotation.dart';

part 'land.g.dart';

@JsonSerializable(explicitToJson: true)
class Land {
  int id;
  double price;
  double landArea;
  String roadAccess;
  String waterSupply;
  DateTime createdAt;
  DateTime updatedAt;

  Land(
      {required this.id,
      required this.price,
      required this.landArea,
      required this.roadAccess,
      required this.waterSupply,
      required this.createdAt,
      required this.updatedAt});

  factory Land.fromJson(Map<String, dynamic> json) => _$LandFromJson(json);

  Map<String, dynamic> toJson() => _$LandToJson(this);
}
