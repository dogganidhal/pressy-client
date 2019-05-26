

import 'package:meta/meta.dart';

class ApiEndpointProvider {

  final String baseUrl;

  ApiEndpointProvider(
    {this.baseUrl: "https://pressy-mobile-api-dev.herokuapp.com/v1"}
  );

  final _ApiAuthEndpoints auth = _ApiAuthEndpoints();
  final _ApiMemberEndpoints members = _ApiMemberEndpoints();
  final _ApiAddressEndpoints addresses = _ApiAddressEndpoints();
  final _ApiOrderEndpoints orders = _ApiOrderEndpoints();
  final _ApiPaymentEndpoints payments = _ApiPaymentEndpoints();

}

class ApiEndpoint {

  final String path;
  final String method;
  final bool needsAuthorization;

  ApiEndpoint({@required this.path, @required this.method, this.needsAuthorization = false});

}

class _ApiAuthEndpoints {

  final ApiEndpoint login = ApiEndpoint(path: "/auth", method: "POST");
  final ApiEndpoint refreshCredentials = ApiEndpoint(path: "/auth/refresh", method: "POST");

}

class _ApiMemberEndpoints {

  final ApiEndpoint signUp = ApiEndpoint(path: "/member", method: "POST");
  final ApiEndpoint memberProfile = ApiEndpoint(path: "/member", method: "GET", needsAuthorization: true);
  final ApiEndpoint editProfile = ApiEndpoint(path: "/member", method: "PATCH", needsAuthorization: true);
  ApiEndpoint validateEmail(String email) => ApiEndpoint(path: "/member/validate-email/$email", method: "GET");
  ApiEndpoint validatePhone(String phone) => ApiEndpoint(path: "/member/validate-phone/$phone", method: "GET");

}

class _ApiAddressEndpoints {

  final ApiEndpoint memberAddresses = ApiEndpoint(path: "/address", method: "GET", needsAuthorization: true);
  final ApiEndpoint editAddress = ApiEndpoint(path: "/address", method: "PATCH", needsAuthorization: true);
  final ApiEndpoint createAddress = ApiEndpoint(path: "/address", method: "POST", needsAuthorization: true);
  ApiEndpoint deleteAddress(int addressId) => ApiEndpoint(path: "/address/$addressId", method: "DELETE", needsAuthorization: true);

}

class _ApiOrderEndpoints {

  final ApiEndpoint getPickupSlots = ApiEndpoint(path: "/order/pickup-slots", method: "GET");
  ApiEndpoint getDeliverySlots(int pickupSlotId) => ApiEndpoint(path: "/order/delivery-slots/$pickupSlotId", method: "GET");
  final ApiEndpoint getArticles = ApiEndpoint(path: "/order/articles", method: "GET");
  final ApiEndpoint getWeightedArticle = ApiEndpoint(path: "/order/weighted-article", method: "GET");
  final ApiEndpoint getOrders = ApiEndpoint(path: "/order", method: "GET", needsAuthorization: true);
  final ApiEndpoint submitOrder = ApiEndpoint(path: "/order", method: "POST", needsAuthorization: true);

}

class _ApiPaymentEndpoints {

  final ApiEndpoint getPaymentAccounts = ApiEndpoint(path: "/payment", method: "GET", needsAuthorization: true);
  final ApiEndpoint addPaymentAccount = ApiEndpoint(path: "/payment", method: "POST", needsAuthorization: true);
  final ApiEndpoint deletePaymentAccounts = ApiEndpoint(path: "/payment", method: "DELETE", needsAuthorization: true);

}