

import 'package:meta/meta.dart';

class ApiEndpointProvider {

  final String baseUrl;

  ApiEndpointProvider(
    {this.baseUrl: "http://localhost:3000/v1"}
  );

  final _ApiAuthEndpoints auth = new _ApiAuthEndpoints();
  final _ApiMemberEndpoints members = new _ApiMemberEndpoints();
  final _ApiAddressEndpoints addresses = new _ApiAddressEndpoints();
  final _ApiOrderEndpoints orders = new _ApiOrderEndpoints();
  final _ApiPaymentEndpoints payments = _ApiPaymentEndpoints();

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

class _ApiOrderEndpoints {

  final ApiEndpoint getPickupSlots = new ApiEndpoint(path: "/order/pickup-slots", method: "GET");
  ApiEndpoint getDeliverySlots(int pickupSlotId) => new ApiEndpoint(path: "/order/delivery-slots/$pickupSlotId", method: "GET");
  final ApiEndpoint getArticles = new ApiEndpoint(path: "/order/articles", method: "GET");
  final ApiEndpoint getWeightedArticle = new ApiEndpoint(path: "/order/weighted-article", method: "GET");
  final ApiEndpoint getOrders = new ApiEndpoint(path: "/order", method: "GET", needsAuthorization: true);
  final ApiEndpoint submitOrder = new ApiEndpoint(path: "/order", method: "POST", needsAuthorization: true);

}

class _ApiPaymentEndpoints {

  final ApiEndpoint getPaymentAccounts = ApiEndpoint(path: "/payment", method: "GET", needsAuthorization: true);
  final ApiEndpoint addPaymentAccount = ApiEndpoint(path: "/payment", method: "POST", needsAuthorization: true);
  final ApiEndpoint deletePaymentAccounts = ApiEndpoint(path: "/payment", method: "DELETE", needsAuthorization: true);

}