import 'package:pressy_client/data/model/auth/auth_credentials/auth_credentials.dart';
import 'package:pressy_client/data/model/member/sign_up_request/sign_up_request.dart';


abstract class IMemberDataSource {

  Future<AuthCredentials> signUp(SignUpRequestModel signUpRequest);

}