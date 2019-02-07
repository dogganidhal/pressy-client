import 'package:json_annotation/json_annotation.dart';
import 'package:pressy_client/data/model/geo/coordindates/coordinates.dart';

part 'create_member_address_details.g.dart';

@JsonSerializable()
class CreateMemberAddressDetails {

  final String name;
  final String extraLine;
  final String googlePlaceId;
  final Coordinates coordinates;

  CreateMemberAddressDetails(
    {this.name, this.extraLine, this.googlePlaceId, this.coordinates}
  );

  factory CreateMemberAddressDetails.fromJson(Map<String, dynamic> json) => _$CreateMemberAddressDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CreateMemberAddressDetailsToJson(this);

}