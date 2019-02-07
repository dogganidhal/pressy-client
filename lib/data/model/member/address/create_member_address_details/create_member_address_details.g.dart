// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_member_address_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMemberAddressDetails _$CreateMemberAddressDetailsFromJson(
    Map<String, dynamic> json) {
  return CreateMemberAddressDetails(
      name: json['name'] as String,
      extraLine: json['extraLine'] as String,
      googlePlaceId: json['googlePlaceId'] as String,
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CreateMemberAddressDetailsToJson(
        CreateMemberAddressDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'extraLine': instance.extraLine,
      'googlePlaceId': instance.googlePlaceId,
      'coordinates': instance.coordinates
    };
