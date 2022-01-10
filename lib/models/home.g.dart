// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) => Home(
      id: json['id'] as int,
      price: (json['price'] as num).toDouble(),
      landArea: (json['landArea'] as num).toDouble(),
      roadAccess: json['roadAccess'] as String,
      waterSupply: json['waterSupply'] as String,
      kitchens: json['kitchens'] as int,
      bathrooms: json['bathrooms'] as int,
      floors: (json['floors'] as num).toDouble(),
      bedrooms: json['bedrooms'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'landArea': instance.landArea,
      'roadAccess': instance.roadAccess,
      'waterSupply': instance.waterSupply,
      'kitchens': instance.kitchens,
      'bathrooms': instance.bathrooms,
      'floors': instance.floors,
      'bedrooms': instance.bedrooms,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
