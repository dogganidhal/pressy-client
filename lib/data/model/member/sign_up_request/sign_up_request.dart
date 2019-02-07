import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequestModel {

  final String email;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;

  SignUpRequestModel({
    @required this.email, @required this.password, @required this.firstName, 
    @required this.phoneNumber, @required this.lastName
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) => _$SignUpRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);

}