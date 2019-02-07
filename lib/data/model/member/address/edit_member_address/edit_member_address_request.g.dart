// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_member_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditMemberAddressRequestModel _$EditMemberAddressRequestModelFromJson(
    Map<String, dynamic> json) {
  return EditMemberAddressRequestModel(
      addressId: json['addressId'] as int,
      addressDetails: json['addressDetails'] == null
          ? null
          : CreateMemberAddressDetails.fromJson(
              json['addressDetails'] as Map<String, dynamic>));
}

Map<String, dynamic> _$EditMemberAddressRequestModelToJson(
        EditMemberAddressRequestModel instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'addressDetails': instance.addressDetails
    };
