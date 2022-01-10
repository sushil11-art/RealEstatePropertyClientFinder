// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['id'] as int,
      sellStatus: json['sellStatus'] as bool,
      images: json['images'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      landId: json['landId'],
      homeId: json['homeId'],
      brokerId: json['brokerId'] as int,
      locationId: json['locationId'] as int,
      land: json['land'],
      broker: Broker.fromJson(json['broker'] as Map<String, dynamic>),
      home: json['home'],
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'sellStatus': instance.sellStatus,
      'images': instance.images,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'landId': instance.landId,
      'homeId': instance.homeId,
      'brokerId': instance.brokerId,
      'locationId': instance.locationId,
      'land': instance.land,
      'broker': instance.broker.toJson(),
      'home': instance.home,
      'location': instance.location.toJson(),
    };
