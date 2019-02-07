// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberAddress _$MemberAddressFromJson(Map<String, dynamic> json) {
  return MemberAddress(
      id: json['id'] as int,
      streetName: json['streetName'] as String,
      streetNumber: json['streetNumber'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
      formattedAddress: json['formattedAddress'] as String,
      name: json['name'] as String,
      extraLine: json['extraLine'] as String);
}

Map<String, dynamic> _$MemberAddressToJson(MemberAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'streetName': instance.streetName,
      'streetNumber': instance.streetNumber,
      'country': instance.country,
      'zipCode': instance.zipCode,
      'formattedAddress': instance.formattedAddress,
      'name': instance.name,
      'extraLine': instance.extraLine
    };
