import 'dart:async';

import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/member/address/create_member_address_details/create_member_address_details.dart';
import 'package:pressy_client/data/model/member/address/edit_member_address/edit_member_address_request.dart';
import 'package:pressy_client/data/model/member/address/member_address/member_address.dart';
import 'package:pressy_client/data/model/member/profile/edit_member_profile/edit_member_profile_request.dart';
import 'package:pressy_client/data/model/member/profile/member_profile/member_profile.dart';
import 'package:pressy_client/data/model/member/sign_up_request/sign_up_request.dart';
import 'package:pressy_client/data/model/payment/credit_card_token/credit_card_token.dart';
import 'package:pressy_client/data/model/payment/payment_acount/payment_account.dart';

abstract class IMemberDataSource {
  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest);
  Future<MemberProfile> getMemberProfile();
  Future<void> editMemberProfile(EditMemberProfileRequestModel request);
  Future<void> validateMemberEmail(String email);
  Future<void> validateMemberPhone(String phone);
  Future<List<MemberAddress>> getMemberAddresses();
  Future<void> editMemberAddress(EditMemberAddressRequestModel request);
  Future<MemberAddress> createMemberAddress(CreateMemberAddressDetails request);
  Future<void> deleteMemberAddress(int addressId);
  Future<PaymentAccount> addPaymentAccount(CreditCardTokenModel token);
}
