

class ApiEndpointProvider {

  final String baseUrl;

  ApiEndpointProvider(
    {this.baseUrl = "https://pressy-mobile-api-dev.herokuapp.com/v1"}
  );

  final _ApiAuthEndpoints authEndpoints = new _ApiAuthEndpoints();
  final _ApiMemberEndpoints memberEndpoints = new _ApiMemberEndpoints();
  final _ApiAddressEndpoints addressEndpoints = new _ApiAddressEndpoints();

}

class _ApiAuthEndpoints {

  final String login = "/auth";
  final String refreshCredentials = "/auth/refresh";

}

class _ApiMemberEndpoints {

  final String signUp = "/member";
  final String memberProfile = "/member";
  final String editProfile = "/member";
  String validateEmail(String email) => "/member/validate-email/$email";
  String validatePhone(String phone) => "/member/validate-phone/$phone";

}

class _ApiAddressEndpoints {

  final String memberAddresses = "/address";
  final String editAddress = "/address";
  final String createAddress = "/address";
  String deleteAddress(int addressId) => "/address/$addressId";

}