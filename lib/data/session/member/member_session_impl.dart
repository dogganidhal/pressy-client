import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';


class MemberSessionImpl implements IMemberSession {

  static const String _MEMBER_PROFILE_KEY = "@pressy/member-profile";
  static const String _DID_PASS_ONBOARDING_KEY = "@pressy/did-pass-onboarding";
  
  @override
  Future<void> deletePersistedMemberProfile() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_MEMBER_PROFILE_KEY);
  }

  @override
  Future<bool> didPassOnBoarding() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_DID_PASS_ONBOARDING_KEY) ?? false;
  }

  @override
  Future<MemberProfile> getPersistedMemberProfile() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var memberProfileString = sharedPreferences.getString(_MEMBER_PROFILE_KEY);
    if (memberProfileString != null) {
      var map = json.decode(memberProfileString);
      return MemberProfile.fromJson(map);
    }
    return null;
  }

  @override
  Future<bool> hasPersistedMemberProfile() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_MEMBER_PROFILE_KEY) != null;
  }

  @override
  Future<void> persistMemberProfile(MemberProfile member) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var memberProfileString = json.encode(member.toJson());
    await sharedPreferences.setString(_MEMBER_PROFILE_KEY, memberProfileString);
  }

  @override
  Future<void> setDidPassOnBoarding() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_DID_PASS_ONBOARDING_KEY, true);
  }

}