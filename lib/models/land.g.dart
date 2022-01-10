// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Land _$LandFromJson(Map<String, dynamic> json) => Land(
      id: json['id'] as int,
      price: (json['price'] as num).toDouble(),
      landArea: (json['landArea'] as num).toDouble(),
      roadAccess: json['roadAccess'] as String,
      waterSupply: json['waterSupply'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LandToJson(Land instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'landArea': instance.landArea,
      'roadAccess': instance.roadAccess,
      'waterSupply': instance.waterSupply,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
