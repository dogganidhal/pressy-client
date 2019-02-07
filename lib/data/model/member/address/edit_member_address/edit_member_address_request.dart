import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/member/address/create_member_address_details/create_member_address_details.dart';

part 'edit_member_address_request.g.dart';

@JsonSerializable()
class EditMemberAddressRequestModel {

  final int addressId;
  final CreateMemberAddressDetails addressDetails;

  EditMemberAddressRequestModel({this.addressId, this.addressDetails});

  factory EditMemberAddressRequestModel.fromJson(Map<String, dynamic> json) => _$EditMemberAddressRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$EditMemberAddressRequestModelToJson(this);

}