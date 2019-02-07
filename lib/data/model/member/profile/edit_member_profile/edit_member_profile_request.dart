import 'package:json_annotation/json_annotation.dart';

part 'edit_member_profile_request.g.dart';

@JsonSerializable()
class EditMemberProfileRequestModel {

  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  EditMemberProfileRequestModel({
    this.firstName, this.lastName, this.email, this.phone
  });

  factory EditMemberProfileRequestModel.fromJson(Map<String, dynamic> json) => _$EditMemberProfileRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$EditMemberProfileRequestModelToJson(this);

}