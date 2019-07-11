import 'dart:async';

import 'package:pressy_client/data/data_source/base/base_data_source.dart';
import 'package:pressy_client/data/data_source/coupon/coupon_data_source.dart';
import 'package:pressy_client/data/model/order/coupon_request/coupon_request.dart';
import 'package:pressy_client/data/model/order/coupon_response/coupon_response.dart';
import 'package:pressy_client/data/resources/provider/endpoint_provider.dart';
import 'package:pressy_client/data/session/auth/auth_session.dart';
import 'package:pressy_client/utils/network/base_client.dart';

class CouponDataSourceImpl extends DataSource implements ICouponsDataSource {
  @override
  final IClient client;

  @override
  final ApiEndpointProvider apiEndpointProvider;

  @override
  final IAuthSession authSession;

  CouponDataSourceImpl(
      {this.client, this.apiEndpointProvider, this.authSession});
  @override
  Future verifyCoupon(String id) {
    return this.handleRequest(
        endpoint: this.apiEndpointProvider.coupon.verify,
        body: {"id": id},
        responseConverter: (json) => CouponVerifyResponseModel.fromJson(json));
  }
}
