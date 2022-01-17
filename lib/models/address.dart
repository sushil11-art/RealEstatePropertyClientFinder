import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  int id;
  int province;
  String district;
  String nagarpalika;
  Address({
    required this.id,
    required this.province,
    required this.district,
    required this.nagarpalika,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
