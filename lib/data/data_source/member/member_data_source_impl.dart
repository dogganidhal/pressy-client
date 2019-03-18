import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/member/address/create_member_address_details/create_member_address_details.dart';
import 'package:pressy_client/data/model/member/address/edit_member_address/edit_member_address_request.dart';
import 'package:pressy_client/data/model/member/address/member_address/member_address.dart';
import 'package:pressy_client/data/model/member/profile/edit_member_profile/edit_member_profile_request.dart';
import 'package:pressy_client/data/model/member/profile/member_profile/member_profile.dart';
import 'package:pressy_client/data/model/member/sign_up_request/sign_up_request.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/utils/network/base_client.dart';


class MemberDataSourceImpl extends DataSource implements IMemberDataSource {

  @override
  final IClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  @override
  final IAuthSession authSession;

  MemberDataSourceImpl({@required this.client, @required this.apiEndpointProvider, @required this.authSession});
  
  @override
  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.signUp,
      body: signUpRequest?.toJson(),
      responseConverter: (json) => AuthCredentials.fromJson(json)
    );
  }

  @override
  Future<void> editMemberProfile(EditMemberProfileRequestModel request) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.editProfile,
      body: request?.toJson(),
    );
  }

  @override
  Future<MemberProfile> getMemberProfile() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.memberProfile,
      responseConverter: (json) => MemberProfile.fromJson(json)
    );
  }

  @override
  Future<void> validateMemberEmail(String email) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.validateEmail(email),
    );
  }

  @override
  Future<void> validateMemberPhone(String phone) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.validatePhone(phone),
    );
  }

  @override
  Future<MemberAddress> createMemberAddress(CreateMemberAddressDetails request) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.addresses.createAddress,
      body: request?.toJson(),
      responseConverter: (json) => MemberAddress.fromJson(json)
    );
  }

  @override
  Future<void> deleteMemberAddress(int addressId) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.addresses.deleteAddress(addressId),
    );
  }

  @override
  Future<void> editMemberAddress(EditMemberAddressRequestModel request) {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.addresses.editAddress,
      body: request?.toJson(),
    );
  }

  @override
  Future<List<MemberAddress>> getMemberAddresses() {
    return this.handleRequest(
      endpoint: this.apiEndpointProvider.members.signUp,
      responseConverter: (json) => json.map((addressJson) => MemberAddress.fromJson(addressJson))
    );
  }

}