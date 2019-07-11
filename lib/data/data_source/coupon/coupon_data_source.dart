import 'dart:async';

import 'package:pressy_client/data/model/order/coupon_request/coupon_request.dart';

abstract class ICouponsDataSource {
  Future verifyCoupon(String id);
//  Future<void> couponValid(bool isValid);
}
