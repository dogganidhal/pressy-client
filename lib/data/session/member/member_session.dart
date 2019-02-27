import 'package:pressy_client/data/model/model.dart';


abstract class IMemberSession {

  MemberProfile get connectedMemberProfile;

  Future<MemberProfile> getPersistedMemberProfile();
  Future<bool> hasPersistedMemberProfile();
  Future<void> persistMemberProfile(MemberProfile member);
  Future<void> deletePersistedMemberProfile();

  Future<bool> didPassOnBoarding();
  Future<void> setDidPassOnBoarding();

}