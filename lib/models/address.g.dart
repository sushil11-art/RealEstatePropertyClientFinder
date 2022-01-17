// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int,
      province: json['province'] as int,
      district: json['district'] as String,
      nagarpalika: json['nagarpalika'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'province': instance.province,
      'district': instance.district,
      'nagarpalika': instance.nagarpalika,
    };
