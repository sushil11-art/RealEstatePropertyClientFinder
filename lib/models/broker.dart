import 'package:json_annotation/json_annotation.dart';

part 'broker.g.dart';

@JsonSerializable(explicitToJson: true)
class Broker {
  int id;
  String username;
  String email;
  String password;
  var imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Broker(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.imageUrl,
      required this.createdAt,
      required this.updatedAt});

  factory Broker.fromJson(Map<String, dynamic> json) => _$BrokerFromJson(json);

  Map<String, dynamic> toJson() => _$BrokerToJson(this);
}
