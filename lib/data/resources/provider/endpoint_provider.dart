

import 'package:meta/meta.dart';

class ApiEndpointProvider {

  final String baseUrl;

  ApiEndpointProvider(
    {this.baseUrl: "https://pressy-mobile-api-dev.herokuapp.com/v1"}
  );

  final _ApiAuthEndpoints authEndpoints = new _ApiAuthEndpoints();
  final _ApiMemberEndpoints memberEndpoints = new _ApiMemberEndpoints();
  final _ApiAddressEndpoints addressEndpoints = new _ApiAddressEndpoints();

}

class ApiEndpoint {

  final String path;
  final String method;
  final bool needsAuthorization;

  ApiEndpoint({@required this.path, @required this.method, this.needsAuthorization = false});

}

class _ApiAuthEndpoints {

  final ApiEndpoint login = new ApiEndpoint(path: "/auth", method: "POST");
  final ApiEndpoint refreshCredentials = new ApiEndpoint(path: "/auth/refresh", method: "POST");

}

class _ApiMemberEndpoints {

  final ApiEndpoint signUp = new ApiEndpoint(path: "/member", method: "POST");
  final ApiEndpoint memberProfile = new ApiEndpoint(path: "/member", method: "GET", needsAuthorization: true);
  final ApiEndpoint editProfile = new ApiEndpoint(path: "/member", method: "PATCH", needsAuthorization: true);
  ApiEndpoint validateEmail(String email) => new ApiEndpoint(path: "/member/validate-email/$email", method: "GET");
  ApiEndpoint validatePhone(String phone) => new ApiEndpoint(path: "/member/validate-phone/$phone", method: "GET");

}

class _ApiAddressEndpoints {

  final ApiEndpoint memberAddresses = new ApiEndpoint(path: "/address", method: "GET", needsAuthorization: true);
  final ApiEndpoint editAddress = new ApiEndpoint(path: "/address", method: "PATCH", needsAuthorization: true);
  final ApiEndpoint createAddress = new ApiEndpoint(path: "/address", method: "POST", needsAuthorization: true);
  ApiEndpoint deleteAddress(int addressId) => new ApiEndpoint(path: "/address/$addressId", method: "DELETE", needsAuthorization: true);

}